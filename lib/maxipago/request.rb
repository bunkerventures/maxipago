# Copyright 2012 Bonera Software e Participações S/A.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


require 'net/https'
require 'uri'

module Maxipago
  class Request

    attr_accessor :api_type, :http_session, :header
    attr_reader :maxid, :apikey, :apiversion

    def initialize(maxid, apikey, apiversion, api_type)
      @maxid = maxid
      @apikey = apikey
      @apiversion = apiversion
      @api_type = api_type
      @uri_transaction = URI.parse(MP_URL_TRANSACTION)
      @uri_api = URI.parse(MP_URL_API)
      @uri_rapi = URI.parse(MP_URL_RAPI)
      @header = {'Content-Type' => 'text/xml'}
    end

    def send_command(opts)
      xml = case self.api_type
      when "transaction" then Maxipago::BuilderTransaction.new(self.maxid, self.apikey, self.apiversion, opts).get_xml_data
      when "api" then Maxipago::BuilderApi.new(self.maxid, self.apikey, self.apiversion, opts).get_xml_data
      when "rapi" then Maxipago::BuilderRapi.new(self.maxid, self.apikey, self.apiversion, opts).get_xml_data
      end
      send_request(xml)
    end

    private

      def send_request(xml)
        build_request

        uri = uri_by_type

        self.http_session.start { |http|
          response = http.post(uri.path, xml, self.header)
          {:header => response, :body => response.body, :message => response.message}
        }
      end

      def build_request
        set_http_session

        if self.http_session.use_ssl?
          self.http_session.verify_mode = OpenSSL::SSL::VERIFY_NONE
          self.http_session.ssl_timeout = 30
        end
      end

      def set_http_session
        if self.api_type == "transaction"
          self.http_session = Net::HTTP.new(@uri_transaction.host, @uri_transaction.port)
          self.http_session.use_ssl = true if @uri_transaction.scheme == "https"
          self.http_session
        end

        if self.api_type == "api"
          self.http_session = Net::HTTP.new(@uri_api.host, @uri_api.port)
          self.http_session.use_ssl = true if @uri_api.scheme == "https"
          self.http_session
        end

        if self.api_type == "rapi"
          self.http_session = Net::HTTP.new(@uri_rapi.host, @uri_rapi.port)
          self.http_session.use_ssl = true if @uri_rapi.scheme == "https"
          self.http_session
        end
      end

      def uri_by_type
        uri = case self.api_type
        when "transaction" then @uri_transaction
        when "api" then @uri_api
        when "rapi" then @uri_rapi
        end
        uri
      end
  end
end
