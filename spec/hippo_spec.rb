require 'hippoload'

describe Hippoload::Hippo do

  let(:basic_conf) { { :connections => 100, :rate => 10, :uri => "/posts" } }
  let(:advanced_conf) { { :uri => "/posts", :connections_and_rates => [{ :connections => 100, :rate => 10 }] } }
  let(:wrong_conf) do 
    {
      :connections => 100, 
      :rate => 10, 
      :uri => "/posts",
      :connections_and_rates => [{ :connections => 100, :rate => 10 }]
    }
  end

  describe "Hippo#attributes_methods" do

    it "should have attributes reader" do
      hippo = Hippoload::Hippo.new(basic_conf)
      hippo.connections.should eql(100)
      hippo.rate.should eql(10)
      hippo.server.should eql('localhost')
      hippo.port.should eql('3000')
      hippo.uri.should eql('/posts')
      hippo.connections_and_rates.should nil
    end

    it "should raise error if wrong conf passed" do
      expect { Hippoload::Hippo.new(wrong_conf) }.to raise_error
    end

    it "should not raise error if correct conf passed" do
      expect { Hippoload::Hippo.new(basic_conf) }.to_not raise_error
    end

    it "should have connections_and_rates attribute if we passed advanced_conf" do
      hippo = Hippoload::Hippo.new(advanced_conf)
      hippo.connections_and_rates.should eql(advanced_conf[:connections_and_rates])
    end

    it "should have default connections and rates if passed advanced_conf without connections_and_rates attribute" do
      advanced_conf.delete(:connections_and_rates)
      hippo = Hippoload::Hippo.new(advanced_conf)
      hippo.connections_and_rates.should eql(hippo.send(:default_connections_and_rates))
    end
  end

  describe "Hippo#attack" do

    it "should return httperf raw output" do
      hippo = Hippoload::Hippo.new(basic_conf)
      hippo.attack.inspect.should include('httperf')
    end

  end

  describe "Hippo#becomes_crazy" do
    it "should return httperf raw output" do
      hippo = Hippoload::Hippo.new(advanced_conf)
      hippo.becomes_crazy
      hippo.becomes_crazy.inspect.should include('httperf')
    end
  end

end
