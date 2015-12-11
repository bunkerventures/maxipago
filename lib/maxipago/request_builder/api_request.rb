require 'net/https'
require 'uri'

module Maxipago
  module RequestBuilder
    class ApiRequest < Maxipago::RequestBuilder::Request
      URL = ENV['MP_URL_API'] || "https://testapi.maxipago.net/UniversalAPI/postAPI"

      private

      def set_uri
        @uri = URI.parse(URL)
      end

      def build_xml(opts)
        Maxipago::XmlBuilder::BuilderApi.new(@maxid, @apikey, @api_version, opts).get_xml_data
      end
    end
  end
end
