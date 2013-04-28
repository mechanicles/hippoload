require 'hippoload'

describe Hippoload::Hippo do

  let(:basic_conf) { { :connections => 100, :rate => 10, :uri => "/posts" } }
  let(:basic_conf) { { :connections => 100, :rate => 10, :uri => "/posts" } }
  let(:wrong_conf) do 
    {
      :connections => 100, 
      :rate => 10, 
      :uri => "/posts",
      :connections_and_rates => [ { :connections => 100, :rate => 10 } ]
    }
  end

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


end
