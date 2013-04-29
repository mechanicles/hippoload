# Hippoload

Basic Ruby wrapper/parser for Httperf

Currently it supports 'get' method of httperf.


## Installation

Add this line to your application's Gemfile:

    gem 'hippoload'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hippoload

## Usage
``` Ruby

require "hippoload"

# for single connections and rate

conf = {:connections => 100, :rate => 10, :uri => "/api/v1/entities?app_token=ef6baaed0d294f8f54eef80aeb8a4ee1" }

hippo = Hippoload::Hippo.new(conf)

hippo_parser = Hippoload::HippoParser.new

raw_output = hippo.attack # for single connections and rate

hippo_parser.parse(raw_output)

# Parsed data => {:total_conenctions=>"100", :duration=>"9.948", :connections_per_second=>"10.1", :min_ms_per_connection=>"33.8", :avg_ms_per_connection=>"61.5", :max_ms_per_connection=>"164.2", :median_ms_per_connection=>"49.5", :stddev_ms_per_connection=>"22.0", :request_rate_per_second=>"10.1", :min_replies_per_second=>"10.0", :avg_replies_per_second=>"10.0", :max_replies_per_second=>"10.0", :stddev_replies_per_second=>"0.0", :samples=>"1", :client_timeout_errors=>"0", :connections_reset_errors=>"0"}

# for connections and rates list

conf = {:connections_and_rates => [{:connections => 100, :rate => 10}, {:connections => 200, :rate => 20}], :uri => "/api/v1/entities?app_token=ef6baaed0d294f8f54eef

hippo = Hippoload::Hippo.new(conf)

hippo.becomes_crazy

# connections list wise => {"100-10-/api/v1/entities?app_token=ef6baaed0d294f8f54eef80aeb8a4ee1"=>"httperf --client=0/1 --server=localhost --port=3000 --uri=/api/v1/entities?app_token=ef6baaed0d294f8f54eef80aeb8a4ee1 --rate=10 --send-buffer=4096 --recv-buffer=16384 --num-conns=100 --num-calls=1\nMaximum connect burst length: 1\n\nTotal: connections 100 requests 100 replies 100 test-duration 9.951 s\n\nConnection rate: 10.0 conn/s (99.5 ms/conn, <=5 concurrent connections)\nConnection time [ms]: min 34.3 avg 69.5 max 400.1 median 50.5 stddev 57.6\nConnection time [ms]: connect 0.1\nConnection length [replies/conn]: 1.000\n\nRequest rate: 10.0 req/s (99.5 ms/req)\nRequest size [B]: 120.0\n\nReply rate [replies/s]: min 10.0 avg 10.0 max 10.0 stddev 0.0 (1 samples)\nReply time [ms]: response 68.9 transfer 0.5\nReply size [B]: header 642.0 content 4901.0 footer 0.0 (total 5543.0)\nReply status: 1xx=0 2xx=100 3xx=0 4xx=0 5xx=0\n\nCPU time [s]: user 2.14 system 7.81 (user 21.5% system 78.5% total 99.9%)\nNet I/O: 55.6 KB/s (0.5*10^6 bps)\n\nErrors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0\nErrors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0\n", "150-15-/api/v1/entities?app_token=ef6baaed0d294f8f54eef80aeb8a4ee1"=>"httperf --client=0/1 --server=localhost --port=3000 --uri=/api/v1/entities?app_token=ef6baaed0d294f8f54eef80aeb8a4ee1 --rate=15 --send-buffer=4096 --recv-buffer=16384 --num-conns=150 --num-calls=1\nMaximum connect burst length: 1\n\nTotal: connections 150 requests 150 replies 150 test-duration 9.988 s\n\nConnection rate: 15.0 conn/s (66.6 ms/conn, <=7 concurrent connections)\nConnection time [ms]: min 34.3 avg 92.1 max 415.4 median 71.5 stddev 68.8\nConnection time [ms]: connect 0.1\nConnection length [replies/conn]: 1.000\n\nRequest rate: 15.0 req/s (66.6 ms/req)\nRequest size [B]: 120.0\n\nReply rate [replies/s]: min 15.0 avg 15.0 max 15.0 stddev 0.0 (1 samples)\nReply time [ms]: response 91.9 transfer 0.0\nReply size [B]: header 642.0 content 4901.0 footer 0.0 (total 5543.0)\nReply status: 1xx=0 2xx=150 3xx=0 4xx=0 5xx=0\n\nCPU time [s]: user 1.76 system 8.21 (user 17.6% system 82.2% total 99.9%)\nNet I/O: 83.1 KB/s (0.7*10^6 bps)\n\nErrors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0\nErrors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0\n"}
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Other similar Ruby gems/libraries

1. [httperfrb](https://github.com/rubyops/httperfrb)
2. [stresser](https://github.com/moviepilot/stresser)
3. [httperf-output-parser](https://github.com/wjessop/httperf-output-parser)

