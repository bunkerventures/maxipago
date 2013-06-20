require 'spec_helper'

describe Maxipago::RequestBuilder::ApiRequest do

  let(:setup) {
    { maxid: "100", apikey: "21g8u6gh6szw1gywfs165vui" }
  }

  before(:each) do
    @api = Maxipago::RequestBuilder::ApiRequest.new(setup[:maxid], setup[:apikey])
  end

  it "gets an error when send a invalid command" do
    expect { @api.send_command({ command: "do_it" }) }.to raise_error(RuntimeError, "Command not defined!")
  end
end
