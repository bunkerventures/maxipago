module Maxipago
  module XmlBuilder
    class BuilderRapi < Maxipago::XmlBuilder::Builder

      private

      def one_transaction_report
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("rapi-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "transactionDetailReport"
            xml.request {
              xml.filterOptions {
                xml.transactionId self.options[:transaction_id]
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def list_transactions_report
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("rapi-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "transactionDetailReport"
            xml.request {
              xml.filterOptions {
                xml.period self.options[:period]
                xml.pageSize self.options[:pagesize] unless self.options[:pagesize].nil?
                xml.startDate self.options[:start_date] unless self.options[:start_date].nil?
                xml.endDate self.options[:end_date] unless self.options[:end_date].nil?
                xml.startTime self.options[:start_time] unless self.options[:start_time].nil?
                xml.endTime self.options[:end_time] unless self.options[:end_time].nil?
                xml.orderByName self.options[:order_by_name] unless self.options[:order_by_name].nil?
                xml.orderByDirection self.options[:order_by_direction] unless self.options[:order_by_direction].nil?
                xml.startRecordNumber self.options[:start_record_number] unless self.options[:start_record_number].nil?
                xml.endRecordNumber self.options[:end_record_number] unless self.options[:end_record_number].nil?
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def transaction_paginate
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("rapi-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "transactionDetailReport"
            xml.request {
              xml.filterOptions {
                xml.pageToken self.options[:page_token]
                xml.pageNumber self.options[:page_number]
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end
    end
  end
end
