module Hippoload
  class Hippo # Hippo acts as httperf but with hippo style :)

    # Currently Hippoload supports only -----------------------------
    # 'get' method of Httperf
    # --num-conns
    # --rate
    # --server
    # --port
    # --uri

    attr_reader :connections, :rate, :server, :port, :uri, :connections_and_rates

    def initialize(conf)

      raise ArgumentError, 'Argument is not hash' unless conf.is_a? Hash

      @connections = conf[:connections]
      @rate = conf[:rate]
      @server = conf[:server] || 'localhost'
      @port = conf[:port] || '3000'
      @uri = conf[:uri]
      @connections_and_rates = if !conf[:connections_and_rates].nil?
                                 conf[:connections_and_rates]
                               elsif @connections.nil? && @rate.nil?
                                 default_connections_and_rates
                               end

      raise Hippo.wrong_conf_message if wrong_configuration
    end

    def attack
      raise "Httperf is not installed on your machine" unless httperf_installed?
      set_connections if @connections.nil?
      set_rate if @rate.nil?
      %x(httperf --num-conns=#{@connections} --rate=#{@rate} --server=#{@server} --port=#{@port} --uri="#{@uri}")
    end

    def becomes_crazy
      return nil if @connections_and_rates.nil?
      raw_outputs = {}
      @connections_and_rates.each do |cr|
        @connections = cr[:connections]
        @rate = cr[:rate]
        raw_outputs["#{@connections}-#{@rate}-#{uri}"] = attack
      end

      raw_outputs
    end

    class << self
      def wrong_conf_message
        "You are missing :connections or :rate arrtibute or may be,
        either assign (:connections, :rate) or assign :connections_and_rates attribute"
      end
    end

    private

    def default_connections_and_rates
      [
        { :connections => 100,  :rate =>  10 },
        { :connections => 200,  :rate =>  20 },
        { :connections => 300,  :rate =>  30 },
        { :connections => 500,  :rate =>  50 },
        { :connections => 700,  :rate =>  70 },
        { :connections => 1000, :rate => 100 }
      ]
    end

    def set_connections
      @connections ||=  default_connections_and_rates[0][:connections]
      puts "--" * 50
      puts "NOTE: You haven't passed the no of connections, so setting default value (#{@connections}) for the connections."
      puts "--" * 50
    end

    def set_rate
      @rate ||=  default_connections_and_rates[0][:rate]
      puts "--" * 50
      puts "NOTE: You haven't passed the value for rate, so setting default value (#{@rate}) for the rate."
      puts "--" * 50
    end

    def wrong_configuration
      (!@connections.nil? || !@rate.nil?) && !@connections_and_rates.nil?
    end

    def httperf_installed?
      system("which httperf > /dev/null 2>&1")
    end
  end
end

