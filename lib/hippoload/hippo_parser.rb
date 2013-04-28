module Hippoload
  class HippoParser

    DATATYPES = %w(
                total_conenctions
                duration
                connections_per_second
                min_ms_per_connection
                avg_ms_per_connection
                max_ms_per_connection
                median_ms_per_connection
                stddev_ms_per_connection
                request_rate_per_second
                min_replies_per_second
                avg_replies_per_second
                max_replies_per_second
                stddev_replies_per_second
                samples
                client_timeout_errors
                connections_reset_errors
               )

    def parse(httperf_raw_output)
      return nil if httperf_raw_output.nil?

      formatted_output = formatted_output(httperf_raw_output)
      matched_data = formatted_output.match(/Total: connections (\d+).+test-duration ([\d.]+).+Connection rate: ([\d.]+).+Connection time \[ms\]: min ([\d.]+).+avg ([\d.]+).+max ([\d.]+).+median ([\d.]+).+stddev ([\d.]+).+Request rate: ([\d.]+).+min ([\d.]+).+avg ([\d.]+).+max ([\d.]+).+stddev ([\d.]+).+(\d+) samples.+client-timo (\d+).+connreset (\d+)/)

      parsed_data = {}
      DATATYPES.size.times do |i|
        parsed_data[DATATYPES[i].to_sym] = matched_data[i+1]
      end

      parsed_data
    end

    private

    def formatted_output(httperf_raw_output)
      httperf_raw_output.inspect.split('\n').join(' ')
    end

  end

end
