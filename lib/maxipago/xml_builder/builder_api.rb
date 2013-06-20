module Maxipago
  module XmlBuilder
    class BuilderApi < Maxipago::XmlBuilder::Builder

      private

      def add_consumer
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId maxid
              xml.merchantKey apikey
            }
            xml.command "add-consumer"
            xml.request {
              xml.customerIdExt options[:customer_id_ext]
              xml.firstName options[:firstname]
              xml.lastName options[:lastname]
              xml.address1 options[:address1] unless options[:address1].nil?
              xml.address2 options[:address2] unless options[:address2].nil?
              xml.city options[:city] unless options[:city].nil?
              xml.state options[:state] unless options[:state].nil?
              xml.zip options[:zip] unless options[:zip].nil?
              xml.phone options[:phone] unless options[:phone].nil?
              xml.email options[:email] unless options[:email].nil?
              xml.dob options[:dob] unless options[:dob].nil?
              xml.ssn options[:ssn] unless options[:ssn].nil?
              xml.sex options[:sex] unless options[:sex].nil?
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def delete_consumer
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
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
        builder.to_xml(indent: 2)
      end

      def update_consumer
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "update-consumer"
            xml.request {
              xml.customerId self.options[:customer_id]
              xml.customerIdExt self.options[:customer_id_ext]
              xml.firstName self.options[:firstname] unless self.options[:firstname].nil?
              xml.lastName self.options[:lastname] unless self.options[:lastname].nil?
              xml.address1 self.options[:address1] unless self.options[:address1].nil?
              xml.address2 self.options[:address2] unless self.options[:address2].nil?
              xml.city self.options[:city] unless self.options[:city].nil?
              xml.state self.options[:state] unless self.options[:state].nil?
              xml.zip self.options[:zip] unless self.options[:zip].nil?
              xml.phone self.options[:phone] unless self.options[:phone].nil?
              xml.email self.options[:email] unless self.options[:email].nil?
              xml.dob self.options[:dob] unless self.options[:dob].nil?
              xml.ssn self.options[:ssn] unless self.options[:ssn].nil?
              xml.sex self.options[:sex] unless self.options[:sex].nil?
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def add_card_onfile
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
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
              xml.billingAddress2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
              xml.billingCity self.options[:billing_city]
              xml.billingState self.options[:billing_state]
              xml.billingZip self.options[:billing_zip]
              xml.billingCountry self.options[:billing_country]
              xml.billingPhone self.options[:billing_phone]
              xml.billingEmail self.options[:billing_email]
              xml.onFileEndDate self.options[:onfile_end_date] unless self.options[:onfile_end_date].nil?
              xml.onFilePermissions self.options[:onfile_permissions] unless self.options[:onfile_permissions].nil?
              xml.onFileComment self.options[:onfile_comment] unless self.options[:onfile_comment].nil?
              xml.onFileMaxChargeAmount self.options[:onfile_max_charge_amount] unless self.options[:onfile_max_charge_amount].nil?
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def delete_card_onfile
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
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
        builder.to_xml(indent: 2)
      end

      def cancel_recurring
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("api-request") {
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.command "cancel-recurring"
            xml.request {
              xml.orderID self.options[:order_id]
            }
          }
        end
        builder.to_xml(indent: 2)
      end
    end
  end
end
