require 'spec_helper'
require 'fakeweb'

describe Maxipago::Client do
  let(:setup) {
      {
        maxid: "100",
        apikey: "21g8u6gh6szw1gywfs165vui",
     }
  }

  let(:api) { Maxipago::RequestBuilder::ApiRequest.new(setup[:maxid], setup[:apikey])}

  before(:each) do
    @mp = Maxipago::Client.new
  end

  it "response should be nil" do
    @mp.response.should eq(nil)
  end

  it "executes a command raises an exception when request is nil" do
    expect { @mp.execute({}) }.to raise_error(RuntimeError, "Sets the api type before execute commands.")
  end

  it "executes a command raises an exception when argument options is empty " do
    @mp.use(api)
    expect { @mp.execute({}) }.to raise_error(ArgumentError, "Execute method needs options")
  end
end