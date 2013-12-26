require 'net/https'
require 'uri'

module Maxipago
  module RequestBuilder
    class RapiRequest < Maxipago::RequestBuilder::Request
      URL = ENV['MP_URL_RAPI'] || "https://testapi.maxipago.net/ReportsAPI/servlet/ReportsAPI"

      private

      def set_uri
        @uri = URI.parse(URL)
      end

      def build_xml(opts)
        Maxipago::XmlBuilder::BuilderRapi.new(@maxid, @apikey, @api_version, opts).get_xml_data
      end
    end
  end
end
