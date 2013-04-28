require 'hippoload'

describe Hippoload::Hippo do

  let(:httperf_raw_output) { "httperf --client=0/1 --server=localhost --port=3000 --uri=/api/v1/entities?app_token=ef6baaed0d294f8f54eef80aeb8a4ee1 --rate=10 --send-buffer=4096 --recv-buffer=16384 --num-conns=100 --num-calls=1\nMaximum connect burst length: 1\n\nTotal: connections 100 requests 100 replies 100 test-duration 9.966 s\n\nConnection rate: 10.0 conn/s (99.7 ms/conn, <=1 concurrent connections)\nConnection time [ms]: min 32.1 avg 55.7 max 94.4 median 46.5 stddev 17.6\nConnection time [ms]: connect 0.1\nConnection length [replies/conn]: 1.000\n\nRequest rate: 10.0 req/s (99.7 ms/req)\nRequest size [B]: 120.0\n\nReply rate [replies/s]: min 10.0 avg 10.0 max 10.0 stddev 0.0 (1 samples)\nReply time [ms]: response 55.5 transfer 0.0\nReply size [B]: header 642.0 content 4901.0 footer 0.0 (total 5543.0)\nReply status: 1xx=0 2xx=100 3xx=0 4xx=0 5xx=0\n\nCPU time [s]: user 2.18 system 7.78 (user 21.9% system 78.0% total 99.9%)\nNet I/O: 55.5 KB/s (0.5*10^6 bps)\n\nErrors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0\nErrors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0\n" }

  it "should have DATATYPES constant" do
    Hippoload::HippoParser::DATATYPES.should_not be_nil
  end

  describe "HippoParser#parse" do

    it "should parse for raw input" do
      parser = Hippoload::HippoParser.new
      parser.parse(httperf_raw_output).size.should  > 0
    end

  end

end
