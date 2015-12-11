require 'spec_helper'

describe Maxipago::RequestBuilder::RapiRequest do

  let(:setup) {
    { maxid: "100", apikey: "21g8u6gh6szw1gywfs165vui" }
  }

  before(:each) do
    @rapi = Maxipago::RequestBuilder::RapiRequest.new(setup[:maxid], setup[:apikey])
  end

  it "gets an error when send a invalid command" do
    expect { @rapi.send_command({ command: "do_it" }) }.to raise_error(RuntimeError, "Command not defined!")
  end
end
