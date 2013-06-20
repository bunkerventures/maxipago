require 'spec_helper'

describe Maxipago::RequestBuilder::Request do

  let(:setup) {
    {
      maxid: "100",
      apikey: "21g8u6gh6szw1gywfs165vui"
    }
  }

  it "should not build the xml to the request" do
    expect {
      Maxipago::RequestBuilder::Request.new(setup[:maxid], setup[:apikey]).send_command({ command: "do-it"}) 
    }.to raise_error(RuntimeError, "This is an abstract method")
  end
end
