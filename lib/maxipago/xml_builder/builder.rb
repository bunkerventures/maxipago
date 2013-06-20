require 'nokogiri'

module Maxipago
  module XmlBuilder
    class Builder

      attr_reader :maxid, :apikey, :apiversion, :command, :options

      MAXIPAGO_COMMANDS = %w(add_consumer delete_consumer update_consumer add_card_onfile delete_card_onfile sale void reversal recurring cancel_recurring bank_bill online_debit save_on_file one_transaction_report list_transactions_report transaction_paginate authorization authentication capture)

      def initialize(maxid, apikey, apiversion, opts)
        @maxid = maxid
        @apikey = apikey
        @apiversion = apiversion
        @command = opts[:command].downcase
        @options = opts
      end

      def get_xml_data
        if command_defined?
          build_xml_data
        else
          raise "Command not defined!"
        end
      end

      private

      def command_defined?
        MAXIPAGO_COMMANDS.include?(self.command)
      end

      def build_xml_data
        method(self.command).call
      end
    end
  end
end
