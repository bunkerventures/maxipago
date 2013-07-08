module Maxipago
  module XmlBuilder
    class BuilderTransaction < Maxipago::XmlBuilder::Builder

      private

      def save_on_file
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
          xml.version self.apiversion
          xml.verification {
            xml.merchantId self.maxid
            xml.merchantKey self.apikey
          }
          xml.order {
            xml.sale {
              xml.processorID self.options[:processor_id]
              xml.referenceNum self.options[:reference_num]
              xml.billing {
                  xml.name self.options[:billing_name] unless self.options[:billing_name].nil?
                  xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                  xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                  xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                  xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                  xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                  xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                  xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                  xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
              }
              xml.transactionDetail {
                xml.payType {
                  xml.creditCard {
                    xml.number self.options[:number]
                    xml.expMonth self.options[:exp_month]
                    xml.expYear self.options[:exp_year]
                    xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].nil?
                    xml.eCommInd "eci"
                  }
                }
              }
              xml.payment {
                xml.chargeTotal self.options[:charge_total]
              }
              xml.saveOnFile {
                xml.customerToken self.options[:customer_id]
                xml.onFileEndDate self.options[:onfile_end_date] unless self.options[:onfile_end_date].nil?
                xml.onFileComment self.options[:onfile_comment] unless self.options[:onfile_comment].nil?
              }
            }
          }
        }
        end
        builder.to_xml(indent: 2)
      end

      def authorization
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
          xml.version self.apiversion
          xml.verification {
            xml.merchantId self.maxid
            xml.merchantKey self.apikey
          }
          xml.order {
            xml.auth {
              xml.fraudCheck self.options[:fraud_check] unless self.options[:fraud_check].nil?
              xml.processorID self.options[:processor_id]
              xml.fraudCheck self.options[:fraud_check] unless self.options[:fraud_check].nil?
              xml.referenceNum self.options[:reference_num]
              xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].nil?
              unless self.options[:billing_name].nil?
                xml.billing {
                  xml.name self.options[:billing_name]
                  xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                  xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                  xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                  xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                  xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                  xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                  xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                  xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
                }
              end
              unless self.options[:shipping_name].nil?
                xml.shipping {
                  xml.name self.options[:shipping_name]
                  xml.address self.options[:shipping_address] unless self.options[:shipping_address].nil?
                  xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].nil?
                  xml.city self.options[:shipping_city] unless self.options[:shipping_city].nil?
                  xml.state self.options[:shipping_state] unless self.options[:shipping_state].nil?
                  xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].nil?
                  xml.country self.options[:shipping_country] unless self.options[:shipping_country].nil?
                  xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].nil?
                  xml.email self.options[:shipping_email] unless self.options[:shipping_email].nil?
                }
              end
              xml.transactionDetail {
                xml.payType {
                  xml.creditCard {
                    xml.number self.options[:number]
                    xml.expMonth self.options[:exp_month]
                    xml.expYear self.options[:exp_year]
                    xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].nil?
                    xml.eCommInd "eci"
                  }
                }
              }
              xml.payment {
                xml.chargeTotal self.options[:charge_total]
                unless self.options[:number_of_installments].nil?
                  xml.creditInstallment {
                    xml.numberOfInstallments self.options[:number_of_installments] unless self.options[:number_of_installments].nil?
                    xml.chargeInterest self.options[:charge_interest] unless self.options[:charge_interest].nil?
                  }
                end
              }
            }
          }
        }
        end
        builder.to_xml(indent: 2)
      end

      def authentication
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.auth {
                xml.processorID self.options[:processor_id]
                xml.authentication self.options[:authentication]
                xml.referenceNum self.options[:reference_num]
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].nil?
                unless self.options[:billing_name].nil?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
                  }
                end
                unless self.options[:shipping_name].nil?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].nil?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].nil?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].nil?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].nil?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].nil?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].nil?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].nil?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].nil?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    xml.creditCard {
                      xml.number self.options[:number]
                      xml.expMonth self.options[:exp_month]
                      xml.expYear self.options[:exp_year]
                      xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].nil?
                      xml.eCommInd "eci"
                    }
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                  unless self.options[:number_of_installments].nil?
                    xml.creditInstallment {
                      xml.numberOfInstallments self.options[:number_of_installments]
                      xml.chargeInterest self.options[:charge_interest]
                    }
                  end
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      # Use xml.capture! because capture is a Kernel method.
      def capture
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.capture! {
                xml.orderID self.options[:order_id]
                xml.referenceNum self.options[:reference_num]
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def sale
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.sale {
                xml.processorID self.options[:processor_id]
                xml.referenceNum self.options[:reference_num]
                xml.fraudCheck self.options[:fraud_check] unless self.options[:fraud_check].nil?
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].nil?
                unless self.options[:billing_name].nil?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
                  }
                end
                unless self.options[:shipping_name].nil?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].nil?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].nil?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].nil?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].nil?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].nil?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].nil?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].nil?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].nil?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    if self.options[:token].nil?
                      xml.creditCard {
                        xml.number self.options[:number]
                        xml.expMonth self.options[:exp_month]
                        xml.expYear self.options[:exp_year]
                        xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].nil?
                        xml.eCommInd "eci"
                      }
                    else
                      xml.onFile {
                        xml.customerId self.options[:customer_id]
                        xml.token self.options[:token]
                      }
                    end
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                  unless self.options[:number_of_installments].nil?
                    xml.creditInstallment {
                      xml.numberOfInstallments self.options[:number_of_installments]
                      xml.chargeInterest self.options[:charge_interest] unless self.options[:charge_interest].nil?
                    }
                  end
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def void
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.void {
                xml.transactionID self.options[:transaction_id]
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def reversal
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.return {
                xml.orderID self.options[:order_id]
                xml.referenceNum self.options[:reference_num]
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def recurring
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.recurringPayment {
                xml.processorID self.options[:processor_id]
                xml.referenceNum self.options[:reference_num]
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].nil?
                unless self.options[:billing_name].nil?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
                  }
                end
                unless self.options[:shipping_name].nil?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].nil?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].nil?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].nil?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].nil?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].nil?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].nil?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].nil?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].nil?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    if self.options[:token].nil?
                      xml.creditCard {
                        xml.number self.options[:number]
                        xml.expMonth self.options[:exp_month]
                        xml.expYear self.options[:exp_year]
                        xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].nil?
                        xml.eCommInd "eci"
                      }
                    else
                      xml.onFile {
                        xml.customerId self.options[:customer_id]
                        xml.token self.options[:token]
                      }
                    end
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
                xml.recurring {
                  xml.action "new"
                  xml.startDate self.options[:start_date]
                  xml.frequency self.options[:frequency]
                  xml.period self.options[:period]
                  xml.installments self.options[:installments]
                  xml.failureThreshold self.options[:failure_threshold]
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def bank_bill
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.sale {
                xml.processorID self.options[:processor_id]
                xml.referenceNum self.options[:reference_num]
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].nil?
                unless self.options[:billing_name].nil?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
                  }
                end
                unless self.options[:shipping_name].nil?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].nil?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].nil?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].nil?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].nil?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].nil?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].nil?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].nil?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].nil?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    xml.boleto {
                      xml.expirationDate self.options[:expiration_date]
                      xml.number self.options[:number]
                      xml.instructions self.options[:instructions] unless self.options[:instructions].nil?
                    }
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end

      def online_debit
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.sale {
                xml.processorID self.options[:processor_id]
                xml.referenceNum self.options[:reference_num]
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].nil?
                unless self.options[:billing_name].nil?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].nil?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].nil?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].nil?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].nil?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].nil?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].nil?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].nil?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].nil?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    xml.onlineDebit {
                      xml.parametersURL self.options[:parameters_url]
                    }
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
              }
            }
          }
        end
        builder.to_xml(indent: 2)
      end
    end
  end
end
