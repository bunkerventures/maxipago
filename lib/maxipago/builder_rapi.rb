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
  class BuilderRapi < Builder

    private
      def one_transaction_report
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
        builder.to_xml(:indent => 2)
      end

      def list_transactions_report
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("rapi-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "transactionDetailReport"
            xml.request {
              xml.filterOptions {
                xml.period self.options[:period]
                xml.pagesize self.options[:pagesize] unless self.options[:pagesize].blank?
                xml.startDate self.options[:start_date] unless self.options[:start_date].blank?
                xml.endDate self.options[:end_date] unless self.options[:end_date].blank?
                xml.startTime self.options[:start_time] unless self.options[:start_time].blank?
                xml.endTime self.options[:end_time] unless self.options[:end_time].blank?
                xml.orderByName self.options[:order_by_name] unless self.options[:order_by_name].blank?
                xml.orderByDirection self.options[:order_by_direction] unless self.options[:order_by_direction].blank?
                xml.startRecordNumber self.options[:start_record_number] unless self.options[:start_record_number].blank?
                xml.endRecordNumber self.options[:end_record_number] unless self.options[:end_record_number].blank?
              }
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def transaction_paginate
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
        builder.to_xml(:indent => 2)
      end
  end
end
