module Hippoload
  class Hippo # Hippo acts as httperf but with hippo style :)

    attr_reader :connections, :rate, :server, :port, :uri, :connections_and_rates

    def initialize(conf)
      @connections = conf[:connections]
      @rate = conf[:rate]
      @server = conf[:server] || 'localhost'
      @port = conf[:port] || '3000'
      @uri = conf[:uri]
      @connections_and_rates = conf[:connections_and_rates] || default_connections_and_rates

      raise_error_if_wrong_conf
    end

    def attack
      set_connections if !@connections.nil?
      set_rate if !@rate.nil?
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

    private

    def default_connections_and_rates
      [
        { :connections => 100,  :rate =>  10 },
        { :connections => 200,  :rate =>  20 },
        { :connections => 300,  :rate =>  30 },
        { :connections => 500,  :rate =>  50 },
        { :connections => 700,  :rate =>  70 },
        { :connections => 1000, :rate => 100 }
      ] if (!@connections.nil? or !@rate.nil?) && !@connections_and_rates.nil?
    end

    def set_connections
      @connections = @connections ||  default_connections_and_rates.first[:connections]
    end

    def set_rate
      @rate = @rate ||  default_connections_and_rates.first[:rate]
    end

    def raise_error_if_wrong_conf
      if (!@connections.nil? || !@rate.nil?) && !@connections_and_rates.nil?
        raise "You can not assign (:connections, :rate) at same with :connections_and_rates attributes. Either assign (:connections, :rate) or assign :connections_and_rates attribute"
      end
    end
  end
end

