require 'spec_helper'
require 'fakeweb'

describe Maxipago::Client do

  context "Api Commands" do
    let(:setup) {
      {
        maxid: "100",
        apikey: "21g8u6gh6szw1gywfs165vui",
        card_number: "4111111111111111",
        cvv: "345",
        exp_month: "12",
        exp_year: "2999"
      }
    }

    let(:api) { Maxipago::RequestBuilder::ApiRequest.new(setup[:maxid], setup[:apikey])}

    before(:each) do
      @mp = Maxipago::Client.new
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "#add_consumer (customer_id_ext exists)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>1</errorCode><errorMessage><![CDATA[consumer already exists in database with this consumerId.]]></errorMessage><time>1367848602198</time></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "add_consumer",
                    customer_id_ext: "1",
                    firstname: "Foo",
                    lastname: "Bar" })
      @mp.response[:body].should eq(body)
    end

    it "#add_customer (customer_id_ext not exists)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>0</errorCode><errorMessage></errorMessage><command>add-consumer</command><time>1367849110845</time><result><customerId>12590</customerId></result></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "add_consumer",
                    customer_id_ext: "13749284",
                    firstname: "Foo",
                    lastname: "Bar",
                    address1: "Rua Foo Bar",
                    address2: "Casa X",
                    city: "Rio de Janeiro",
                    state: "RJ",
                    zip: "11111-111",
                    phone: "(11) 1111-1111",
                    email: "foo@bar.com",
                    dob: "08/03/1980",
                    sex: "M" })
      @mp.response[:body].should eq(body)
    end

    it "#delete_consumer" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>0</errorCode><errorMessage></errorMessage><command>delete-consumer</command><time>1367849110845</time></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "delete_consumer",
                    customer_id: "1156" })
      @mp.response[:body].should eq(body)
    end

    it "#update_consumer (customer_id_ext not exists)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>1</errorCode><errorMessage><![CDATA[A consumer already exists in the database with this consumerId.]]></errorMessage><time>1367853413185</time></api-response>"

      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                           body: body,
                           status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "update_consumer",
                    customer_id: "11017",
                    customer_id_ext: "21312",
                    firstname: "Foo",
                    lastname: "Bar",
                    address1: "Rua Foo Bar",
                    address2: "Casa X",
                    city: "Rio de Janeiro",
                    state: "RJ",
                    zip: "11111-111",
                    phone: "(11) 1111-1111",
                    email: "foo@bar.com",
                    dob: "08/03/1980",
                    sex: "M" })
      @mp.response[:body].should eq(body)
    end

    it "#update_consumer (customer_id_ext exists)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>0</errorCode><errorMessage></errorMessage><command>update-consumer</command><time>1367851892878</time><result></result></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "update_consumer",
                    customer_id: "12594",
                    customer_id_ext: "11234",
                    firstname: "Foo",
                    lastname: "Bar",
                    address1: "Rua Foo Bar",
                    address2: "Casa X",
                    city: "Rio de Janeiro",
                    state: "RJ",
                    zip: "11111-111",
                    phone: "(11) 1111-1111",
                    email: "foo@bar.com",
                    dob: "08/03/1980",
                    sex: "M" })
      @mp.response[:body].should eq(body)
    end

    it "#add_card_onfile" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>0</errorCode><errorMessage></errorMessage><command>add-card-onfile</command><time>1367855065607</time><result><token>5e3K+bwTdBg=</token></result></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "add_card_onfile",
                    customer_id: "12837",
                    credit_card_number: setup[:card_number],
                    expiration_month: setup[:exp_month],
                    expiration_year: setup[:exp_year],
                    billing_name: "Foo Bar",
                    billing_address1: "Rua Foo Bar",
                    billing_address2: "Casa X",
                    billing_city: "Rio de Janeiro",
                    billing_state: "RJ",
                    billing_zip: "11111-111",
                    billing_country: "BR",
                    billing_phone: "(11) 1111-1111",
                    billing_email: "foo@bar.com",
                    onfile_end_date: "12/01/2015",
                    onfile_permissions: "ongoing",
                    onfile_comment: "Cartao 1",
                    onfile_max_charge_amount: "500.00" })
      @mp.response[:body].should eq(body)
    end

    it "#delete_card_onfile" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>0</errorCode><errorMessage></errorMessage><command>delete-card-onfile</command><time>1367855583207</time><result></result></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(api)
      @mp.execute({ command: "delete_card_onfile",
                    customer_id: "11008",
                    token: "5e3K+bwTdBg=" })
      @mp.response[:body].should eq(body)
    end

    it "#cancel_recurring" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><api-response><errorCode>0</errorCode><errorMessage></errorMessage><command>cancel-recurring</command><time>1368210545916</time><result></result></api-response>"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::ApiRequest::URL,
                            body: body,
                            status: ["200", "OK"] )

      @mp.use(api)
      @mp.execute({ command: "cancel_recurring",
                    maxid: setup[:maxid],
                    apikey: setup[:apikey],
                    order_id: "0AF90437:013E8F9BAAA9:5A38:01849C5C" }) 
      @mp.response[:body].should eq(body)
    end
  end
end
