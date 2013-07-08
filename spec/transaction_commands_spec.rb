require 'spec_helper'
require 'fakeweb'

describe Maxipago::Client do

  context "Transaction Commands" do
    let(:setup) {
      {
        maxid: "100",
        apikey: "21g8u6gh6szw1gywfs165vui",
        card_number: "4111111111111111",
        card_number_fraud: "4901720380077300",
        card_number_fraud2: "4901720366459100",
        cvv: "345",
        exp_month: "12",
        exp_year: "2999"
      }
    }

    let(:transaction) { Maxipago::RequestBuilder::TransactionRequest.new(setup[:maxid], setup[:apikey])}

    before(:each) do
      @mp = Maxipago::Client.new
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "#authorization" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E8F22A46F:94D9:01EC3389</orderID>\n<referenceNum>21312</referenceNum>\n<transactionID>505104</transactionID>\n<transactionTimestamp>1368201012</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>AUTHORIZED</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n<fraudScore>49</fraudScore>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "authorization",
                    processor_id: "1",
                    reference_num: "21312",
                    number: setup[:card_number],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    charge_total: "1.98" })
      @mp.response[:body].should eq(body)
    end

    it "#capture" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID>0AF90437:013E8F22A46F:94D9:01EC3389</orderID>\n<referenceNum>21312</referenceNum>\n<transactionID>505107</transactionID>\n<transactionTimestamp>1368201109</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode/>\n<cvvResponseCode/>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "capture",
                    order_id: "0AF90437:013E8F22A46F:94D9:01EC3389",
                    reference_num: "21312",
                    charge_total: "1.98" })
      @mp.response[:body].should eq(body)
    end

    it "#sale" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E8F250869:AC7B:0010F884</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505109</transactionID>\n<transactionTimestamp>1368201169</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n<fraudScore>49</fraudScore>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "sale",
                    processor_id: "1",
                    reference_num: "21313",
                    billing_name: "Foo Bar",
                    fraud_check: "Y",
                    number: setup[:card_number],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    charge_total: "2.99" })
      @mp.response[:body].should eq(body)
    end

    it "#sale (declined)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID>0AF90437:013E8FBC76B7:4C3F:016AE079</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505207</transactionID>\n<transactionTimestamp>1368211093221</transactionTimestamp>\n<responseCode>1</responseCode>\n<responseMessage>DECLINED</responseMessage>\n<avsResponseCode>NNN</avsResponseCode>\n<cvvResponseCode>N</cvvResponseCode>\n<processorCode>D</processorCode>\n<processorMessage>DECLINED</processorMessage>\n<errorMessage/>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "sale",
                    processor_id: "1",
                    reference_num: "21313",
                    billing_name: "DHH",
                    fraud_check: "Y",
                    number: setup[:card_number],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    charge_total: "2.99" })
      @mp.response[:body].should eq(body)
    end

    it "#sale (fraud)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E8FCA91DB:8119:00C441BF</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505226</transactionID>\n<transactionTimestamp>1368212017</transactionTimestamp>\n<responseCode>2</responseCode>\n<responseMessage>FRAUD</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>D</processorCode>\n<processorMessage>VIP List (Email, Card)</processorMessage>\n<errorMessage/>\n<fraudScore>29</fraudScore>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "sale",
                    processor_id: "1",
                    reference_num: "21313",
                    billing_name: "DHH",
                    fraud_check: "Y",
                    number: setup[:card_number_fraud],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    charge_total: "2.98" })
      @mp.response[:body].should eq(body)
    end

    it "#sale (fraud revision)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E8FCB9F58:5406:017D4FCF</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505231</transactionID>\n<transactionTimestamp>1368212086</transactionTimestamp>\n<responseCode>2</responseCode>\n<responseMessage>FRAUD</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>R</processorCode>\n<processorMessage>VIP List (Email, Card)</processorMessage>\n<errorMessage/>\n<fraudScore>29</fraudScore>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "sale",
                    processor_id: "1",
                    reference_num: "21313",
                    billing_name: "DHH",
                    fraud_check: "Y",
                    number: setup[:card_number_fraud2],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    charge_total: "2.98" })
      @mp.response[:body].should eq(body)
    end

    it "#void" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID/>\n<referenceNum/>\n<transactionID>505107</transactionID>\n<transactionTimestamp/>\n<responseCode>0</responseCode>\n<responseMessage>VOIDED</responseMessage>\n<avsResponseCode/>\n<cvvResponseCode/>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "void",
                    transaction_id: "505107" })
      @mp.response[:body].should eq(body)
    end

    it "#reversal" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID>0AF90437:013E8F8BA24E:B68E:00DF7C9C</orderID>\n<referenceNum>21312</referenceNum>\n<transactionID>505180</transactionID>\n<transactionTimestamp>1368208175</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode/>\n<cvvResponseCode/>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "reversal",
                    order_id: "0AF90437:013E8F8BA24E:B68E:00DF7C9C",
                    reference_num: "21312",
                    charge_total: "10.00" })
      @mp.response[:body].should eq(body)
    end

    it "#recurring" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E8F9BAAA9:5A38:01849C5C</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505182</transactionID>\n<transactionTimestamp>1368208943</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "recurring",
                    processor_id: "1",
                    reference_num: "21313",
                    number: setup[:card_number],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    charge_total: "2.98",
                    start_date: "2013-05-10",
                    period: "monthly",
                    frequency: "1",
                    installments: "5",
                    failure_threshold: "1" })
      @mp.response[:body].should eq(body)
    end

    it "#bank_bill" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID>10000000</orderID>\n<referenceNum/>\n<transactionID>505242</transactionID>\n<transactionTimestamp>1368212667</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>ISSUED</responseMessage>\n<avsResponseCode/>\n<cvvResponseCode/>\n<processorCode/>\n<processorMessage/>\n<errorMessage/>\n<boletoUrl>https://testboletos.maxipago.net/redirection_service/boleto?ref=LmO9fsnOXyUgTcRusHkbMQFQxVkk9OBmXEK5CanaeV8JEVxxqROSIw5u0BQdXimvTSC4pnEbe8gb%0ApOInSCVNmw%3D%3D</boletoUrl>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "bank_bill",
                    processor_id: "12",
                    reference_num: "21313",
                    billing_name: "Foo Bar",
                    billing_address: "Rua Foo Bar",
                    billing_address2: "Complemento Bar",
                    billing_city: "Rio de Janeiro",
                    billing_state: "RJ",
                    billing_postalcode: "11111-111",
                    billing_phone: "111111111",
                    billing_email: "foo@bar.com",
                    expiration_date: "2013-05-15",
                    number: "10000001",
                    charge_total: "10.00" })
      @mp.response[:body].should eq(body)
    end

    it "#bank_bill (exists)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID/>\n<referenceNum/>\n<transactionID/>\n<transactionTimestamp>1368212818741</transactionTimestamp>\n<responseCode>1024</responseCode>\n<responseMessage>INVALID REQUEST</responseMessage>\n<avsResponseCode/>\n<cvvResponseCode/>\n<processorCode/>\n<processorMessage/>\n<errorMessage>A transaction with boletoNumber = 10000000 already exists in the database.</errorMessage>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "bank_bill",
                    processor_id: "12",
                    reference_num: "21313",
                    billing_name: "Foo Bar",
                    billing_address: "Rua Foo Bar",
                    billing_address2: "Complemento Bar",
                    billing_city: "Rio de Janeiro",
                    billing_state: "RJ",
                    billing_postalcode: "11111-111",
                    billing_phone: "111111111",
                    billing_email: "foo@bar.com",
                    expiration_date: "2013-05-15",
                    number: "10000000",
                    charge_total: "10.00" })
      @mp.response[:body].should eq(body)
    end

    it "#online_debit" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode/>\n<orderID>0AF90437:013E8FE45328:2C20:019B510E</orderID>\n<referenceNum/>\n<transactionID>505256</transactionID>\n<transactionTimestamp>1368213705</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>PENDING</responseMessage>\n<avsResponseCode/>\n<cvvResponseCode/>\n<processorCode/>\n<processorMessage/>\n<errorMessage/>\n<onlineDebitUrl>https://testauthentication.maxipago.net/redirection_service/debit?ref=s2hivc4Ayusg031Qez0h2hlED%2Bgw89Qt%2BMvvt5BasRAgP4LP6ZwYRuTDxJ65jBQOtiB%2F9Z%2FmP45L%0Ax%2FsLbLqkiQ%3D%3D</onlineDebitUrl>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )

      @mp.use(transaction)
      @mp.execute({ command: "online_debit",
                    processor_id: "17",
                    reference_num: "21313",
                    billing_name: "Foo Bar",
                    billing_address: "Rua Foo Bar",
                    billing_address2: "Complemento Bar",
                    billing_city: "Rio de Janeiro",
                    billing_state: "RJ",
                    billing_postalcode: "11111-111",
                    billing_phone: "111111111",
                    billing_email: "foo@bar.com",
                    parameters_url: "id=123456&tp=3",
                    charge_total: "10.00" })
      @mp.response[:body].should eq(body)
    end

    it "#sale (token)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E8FF476DB:1EF0:00BA2507</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505277</transactionID>\n<transactionTimestamp>1368214763</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n<fraudScore>49</fraudScore>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "sale",
                    processor_id: "1",
                    reference_num: "21313",
                    customer_id: "12837",
                    token: "Fmj2jBtkxG0=",
                    charge_total: "10.00" })
      @mp.response[:body].should eq(body)
    end

    it "#recurring (token)" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E901B0D80:714F:00CC1BD3</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505303</transactionID>\n<transactionTimestamp>1368217292</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "recurring",
                    processor_id: "1",
                    reference_num: "21313",
                    customer_id: "12837",
                    token: "Fmj2jBtkxG0=",
                    charge_total: "2.98",
                    start_date: "2013-05-10",
                    period: "monthly",
                    frequency: "1",
                    installments: "5",
                    failure_threshold: "1" })
      @mp.response[:body].should eq(body)
    end

    it "#save_on_file" do
      body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction-response>\n<authCode>123456</authCode>\n<orderID>0AF90437:013E9023488D:ECC6:007F3311</orderID>\n<referenceNum>21313</referenceNum>\n<transactionID>505308</transactionID>\n<transactionTimestamp>1368217831</transactionTimestamp>\n<responseCode>0</responseCode>\n<responseMessage>CAPTURED</responseMessage>\n<avsResponseCode>YYY</avsResponseCode>\n<cvvResponseCode>M</cvvResponseCode>\n<processorCode>A</processorCode>\n<processorMessage>APPROVED</processorMessage>\n<errorMessage/>\n<fraudScore>49</fraudScore>\n<save-on-file>\n<error>billingCountry is a required field.</error>\n</save-on-file>\n</transaction-response>\n"
      FakeWeb.register_uri( :post, Maxipago::RequestBuilder::TransactionRequest::URL,
                            body: body,
                            status: ["200", "OK"] )
      @mp.use(transaction)
      @mp.execute({ command: "save_on_file",
                    processor_id: "1",
                    reference_num: "21313",
                    billing_name: "Foo Bar",
                    billing_address: "Rua Foo Bar",
                    billing_address2: "Complemento Bar",
                    billing_city: "Rio de Janeiro",
                    billing_state: "RJ",
                    billing_postalcode: "11111-111",
                    billing_phone: "111111111",
                    billing_email: "foo@bar.com",
                    number: setup[:card_number],
                    exp_month: setup[:exp_month],
                    exp_year: setup[:exp_year],
                    cvv_number: setup[:cvv],
                    customer_id: "10958",
                    onfile_end_date: "12/25/2020",
                    charge_total: "10.00" })

      @mp.response[:body].should eq(body)
    end
  end
end
