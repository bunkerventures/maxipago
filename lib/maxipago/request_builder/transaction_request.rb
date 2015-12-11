require 'net/https'
require 'uri'

module Maxipago
  module RequestBuilder
    class TransactionRequest < Maxipago::RequestBuilder::Request
      URL = ENV['MP_URL_TRANSACTION'] || "https://testapi.maxipago.net/UniversalAPI/postXML"

      private

      def set_uri
        @uri = URI.parse(URL)
      end

      def build_xml(opts)
        Maxipago::XmlBuilder::BuilderTransaction.new(@maxid, @apikey, @api_version, opts).get_xml_data
      end
    end
  end
end
