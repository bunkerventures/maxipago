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


module Maxipago
  class Client

    attr_accessor :maxid, :apikey, :apiversion, :api, :request, :response

    def initialize(maxid, apikey, apiversion)
      @maxid = maxid
      @apikey = apikey
      @apiversion = apiversion
    end

    def use(api_type)
      return self.request = use_request(api_type)
    end

    def command(opts = {})
      self.response = do_request(opts)
    end

    private

      def use_request(api_type)
        self.api = api_type
        Maxipago::Request.new(maxid, apikey, apiversion, api_type)
      end

      def do_request(opts)
        request.send_command(opts)
      end
  end
end
