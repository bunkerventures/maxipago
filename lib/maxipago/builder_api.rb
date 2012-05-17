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
  class BuilderApi < Builder
    private
      def add_consumer
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "add-consumer"
            xml.request {
              xml.customerIdExt self.options[:customer_id_ext]
              xml.firstName self.options[:firstname]
              xml.lastName self.options[:lastname]
              xml.address1 self.options[:address1] unless self.options[:address1].blank?
              xml.address2 self.options[:address2] unless self.options[:address2].blank?
              xml.city self.options[:city] unless self.options[:city].blank?
              xml.state self.options[:state] unless self.options[:state].blank?
              xml.zip self.options[:zip] unless self.options[:zip].blank?
              xml.phone self.options[:phone] unless self.options[:phone].blank?
              xml.email self.options[:email] unless self.options[:email].blank?
              xml.dob self.options[:dob] unless self.options[:dob].blank?
              xml.ssn self.options[:ssn] unless self.options[:ssn].blank?
              xml.sex self.options[:sex] unless self.options[:sex].blank?
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def delete_consumer
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "delete-consumer"
            xml.request {
              xml.customerId self.options[:customer_id]
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def update_consumer
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "update-consumer"
            xml.request {
              xml.customerId self.options[:customer_id]
              xml.customerIdExt self.options[:customer_id_ext]
              xml.firstName self.options[:firstname] unless self.options[:firstname].blank?
              xml.lastName self.options[:lastname] unless self.options[:lastname].blank?
              xml.address1 self.options[:address1] unless self.options[:address1].blank?
              xml.address2 self.options[:address2] unless self.options[:address2].blank?
              xml.city self.options[:city] unless self.options[:city].blank?
              xml.state self.options[:state] unless self.options[:state].blank?
              xml.zip self.options[:zip] unless self.options[:zip].blank?
              xml.phone self.options[:phone] unless self.options[:phone].blank?
              xml.email self.options[:email] unless self.options[:email].blank?
              xml.dob self.options[:dob] unless self.options[:dob].blank?
              xml.ssn self.options[:ssn] unless self.options[:ssn].blank?
              xml.sex self.options[:sex] unless self.options[:sex].blank?
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def add_card_onfile
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "add-card-onfile"
            xml.request {
              xml.customerId self.options[:customer_id]
              xml.creditCardNumber self.options[:credit_card_number]
              xml.expirationMonth self.options[:expiration_month]
              xml.expirationYear self.options[:expiration_year]
              xml.billingName self.options[:billing_name]
              xml.billingAddress1 self.options[:billing_address1]
              xml.billingAddress2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
              xml.billingCity self.options[:billing_city]
              xml.billingState self.options[:billing_state]
              xml.billingZip self.options[:billing_zip]
              xml.billingCountry self.options[:billing_country]
              xml.billingPhone self.options[:billing_phone]
              xml.billingEmail self.options[:billing_email]
              xml.onFileEndDate self.options[:onfile_end_date] unless self.options[:onfile_end_date].blank?
              xml.onFilePermissions self.options[:onfile_permissions] unless self.options[:onfile_permissions].blank?
              xml.onFileComment self.options[:onfile_comment] unless self.options[:onfile_comment].blank?
              xml.onFileMaxChargeAmount self.options[:onfile_max_charge_amount] unless self.options[:onfile_max_charge_amount].blank?
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def delete_card_onfile
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "delete-card-onfile"
            xml.request {
              xml.customerId self.options[:customer_id]
              xml.token self.options[:token]
            }
          }
        end
        builder.to_xml(:indent => 2)
      end
  end
end
