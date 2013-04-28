module Hippoload
  class Hippo # Hippo acts as httperf

    attr_reader :connections, :rate, :server, :port, :uri, :connections_and_rates

    def initialize(conf)

      @connections = conf[:connections]
      @rate = conf[:rate]
      @server = conf[:server] || 'localhost'
      @port = conf[:port] || '3000'
      @uri = conf[:uri]
      @connections_and_rates = conf[:connections_and_rates] #|| default_connections_and_rates

      raise_error_if_wrong_conf
    end

    private

    def raise_error_if_wrong_conf
      if (!connections.nil? || !rate.nil?) && !connections_and_rates.nil?
        raise "You can not assign (:connections, :rate) at same with :connections_and_rates attributes. Either assign (:connections, :rate) or assign :connections_and_rates attribute"
      end
    end
  end
end

