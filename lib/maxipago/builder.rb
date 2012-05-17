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


require 'nokogiri'

module Maxipago
  class Builder

    attr_reader :maxid, :apikey, :apiversion, :command, :options

    MAXIPAGO_COMMANDS = %w(add_consumer delete_consumer update_consumer add_card_onfile delete_card_onfile sale void reversal recurring bank_bill save_on_file one_transaction_report list_transactions_report transaction_paginate authorization authentication capture)

    def initialize(maxid, apikey, apiversion, opts)
      @maxid = maxid
      @apikey = apikey
      @apiversion = apiversion
      @command = opts[:command].downcase
      @options = opts
    end

    def get_xml_data
      command_defined? ? build_xml_data : "Command not defined! Ex: add_consumer"
    end

    private

      def command_defined?
        MAXIPAGO_COMMANDS.include?(self.command) ? true : false
      end

      def build_xml_data
        method(self.command).call
      end
  end
end
