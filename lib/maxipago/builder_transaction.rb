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
  class BuilderTransaction < Builder

    private
      def save_on_file
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
                  xml.name self.options[:billing_name] unless self.options[:billing_name].blank?
                  xml.address self.options[:billing_address] unless self.options[:billing_address].blank?
                  xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
                  xml.city self.options[:billing_city] unless self.options[:billing_city].blank?
                  xml.state self.options[:billing_state] unless self.options[:billing_state].blank?
                  xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].blank?
                  xml.country self.options[:billing_country] unless self.options[:billing_country].blank?
                  xml.phone self.options[:billing_phone] unless self.options[:billing_phone].blank?
                  xml.email self.options[:billing_email] unless self.options[:billing_email].blank?
              }
              xml.transactionDetail {
                xml.payType {
                  xml.creditCard {
                    xml.number self.options[:number]
                    xml.expMonth self.options[:exp_month]
                    xml.expYear self.options[:exp_year]
                    xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].blank?
                    xml.eCommInd "eci"
                  }
                }
              }
              xml.payment {
                xml.chargeTotal self.options[:charge_total]
              }
              xml.saveOnFile {
                xml.customerToken self.options[:customer_token]
                xml.onFileEndDate self.options[:onfile_end_date] unless self.options[:onfile_end_date].blank?
                xml.onFileComment self.options[:onfile_comment] unless self.options[:onfile_comment].blank?
              }
            }
          }
        }
        end
        builder.to_xml(:indent => 2)
      end

      def authorization
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("transaction-request") {
          xml.version self.apiversion
          xml.verification {
            xml.merchantId self.maxid
            xml.merchantKey self.apikey
          }
          xml.order {
            xml.auth {
              xml.processorID self.options[:processor_id]
              xml.referenceNum self.options[:reference_num]
              xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].blank?
              unless self.options[:billing_name].blank?
                xml.billing {
                  xml.name self.options[:billing_name]
                  xml.address self.options[:billing_address] unless self.options[:billing_address].blank?
                  xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
                  xml.city self.options[:billing_city] unless self.options[:billing_city].blank?
                  xml.state self.options[:billing_state] unless self.options[:billing_state].blank?
                  xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].blank?
                  xml.country self.options[:billing_country] unless self.options[:billing_country].blank?
                  xml.phone self.options[:billing_phone] unless self.options[:billing_phone].blank?
                  xml.email self.options[:billing_email] unless self.options[:billing_email].blank?
                }
              end
              unless self.options[:shipping_name].blank?
                xml.shipping {
                  xml.name self.options[:shipping_name]
                  xml.address self.options[:shipping_address] unless self.options[:shipping_address].blank?
                  xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].blank?
                  xml.city self.options[:shipping_city] unless self.options[:shipping_city].blank?
                  xml.state self.options[:shipping_state] unless self.options[:shipping_state].blank?
                  xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].blank?
                  xml.country self.options[:shipping_country] unless self.options[:shipping_country].blank?
                  xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].blank?
                  xml.email self.options[:shipping_email] unless self.options[:shipping_email].blank?
                }
              end
              xml.transactionDetail {
                xml.payType {
                  xml.creditCard {
                    xml.number self.options[:number]
                    xml.expMonth self.options[:exp_month]
                    xml.expYear self.options[:exp_year]
                    xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].blank?
                    xml.eCommInd "eci"
                  }
                }
              }
              xml.payment {
                xml.chargeTotal self.options[:charge_total]
                unless self.options[:number_of_installments].blank?
                  xml.creditInstallment {
                    xml.numberOfInstallments self.options[:number_of_installments] unless self.options[:number_of_installments].blank?
                    xml.chargeInterest self.options[:charge_interest] unless self.options[:charge_interest].blank?
                  }
                end
              }
            }
          }
        }
        end
        builder.to_xml(:indent => 2)
      end

      def authentication
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].blank?
                unless self.options[:billing_name].blank?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].blank?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].blank?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].blank?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].blank?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].blank?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].blank?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].blank?
                  }
                end
                unless self.options[:shipping_name].blank?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].blank?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].blank?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].blank?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].blank?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].blank?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].blank?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].blank?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].blank?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    xml.creditCard {
                      xml.number self.options[:number]
                      xml.expMonth self.options[:exp_month]
                      xml.expYear self.options[:exp_year]
                      xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].blank?
                      xml.eCommInd "eci"
                    }
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                  unless self.options[:number_of_installments].blank?
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
        builder.to_xml(:indent => 2)
      end

      # Use xml.capture! because capture is a Kernel method.
      def capture
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].blank?
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
              }
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def sale
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].blank?
                unless self.options[:billing_name].blank?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].blank?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].blank?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].blank?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].blank?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].blank?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].blank?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].blank?
                  }
                end
                unless self.options[:shipping_name].blank?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].blank?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].blank?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].blank?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].blank?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].blank?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].blank?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].blank?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].blank?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    if self.options[:token].blank?
                      xml.creditCard {
                        xml.number self.options[:number]
                        xml.expMonth self.options[:exp_month]
                        xml.expYear self.options[:exp_year]
                        xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].blank?
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
                  unless self.options[:number_of_installments].blank?
                    xml.creditInstallment {
                      xml.numberOfInstallments self.options[:number_of_installments]
                      xml.chargeInterest self.options[:charge_interest] unless self.options[:charge_interest].blank?
                    }
                  end
                }
              }
            }
          }
        end
        builder.to_xml(:indent => 2)
      end

      def void
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
        builder.to_xml(:indent => 2)
      end

      def reversal
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
        builder.to_xml(:indent => 2)
      end

      def recurring
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.send("transaction-request") {
            xml.version self.apiversion
            xml.verification {
              xml.merchantId self.maxid
              xml.merchantKey self.apikey
            }
            xml.order {
              xml.recurringPayment {
                xml.orderID self.options[:order_id]
                xml.referenceNum self.options[:reference_num]
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].blank?
                unless self.options[:billing_name].blank?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].blank?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].blank?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].blank?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].blank?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].blank?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].blank?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].blank?
                  }
                end
                unless self.options[:shipping_name].blank?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].blank?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].blank?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].blank?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].blank?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].blank?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].blank?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].blank?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].blank?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    xml.creditCard {
                      xml.number self.options[:number]
                      xml.expMonth self.options[:exp_month]
                      xml.expYear self.options[:exp_year]
                      xml.cvvNumber self.options[:cvv_number] unless self.options[:cvv_number].blank?
                      xml.eCommInd "eci"
                    }
                  }
                }
                xml.payment {
                  xml.chargeTotal self.options[:charge_total]
                }
                xml.recurring {
                  xml.action self.options[:action]
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
        builder.to_xml(:indent => 2)
      end

      def bank_bill
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
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
                xml.ipAddress self.options[:ip_address] unless self.options[:ip_address].blank?
                unless self.options[:billing_name].blank?
                  xml.billing {
                    xml.name self.options[:billing_name]
                    xml.address self.options[:billing_address] unless self.options[:billing_address].blank?
                    xml.address2 self.options[:billing_address2] unless self.options[:billing_address2].blank?
                    xml.city self.options[:billing_city] unless self.options[:billing_city].blank?
                    xml.state self.options[:billing_state] unless self.options[:billing_state].blank?
                    xml.postalcode self.options[:billing_postalcode] unless self.options[:billing_postalcode].blank?
                    xml.country self.options[:billing_country] unless self.options[:billing_country].blank?
                    xml.phone self.options[:billing_phone] unless self.options[:billing_phone].blank?
                    xml.email self.options[:billing_email] unless self.options[:billing_email].blank?
                  }
                end
                unless self.options[:shipping_name].blank?
                  xml.shipping {
                    xml.name self.options[:shipping_name]
                    xml.address self.options[:shipping_address] unless self.options[:shipping_address].blank?
                    xml.address2 self.options[:shipping_address2] unless self.options[:shipping_address2].blank?
                    xml.city self.options[:shipping_city] unless self.options[:shipping_city].blank?
                    xml.state self.options[:shipping_state] unless self.options[:shipping_state].blank?
                    xml.postalcode self.options[:shipping_postalcode] unless self.options[:shipping_postalcode].blank?
                    xml.country self.options[:shipping_country] unless self.options[:shipping_country].blank?
                    xml.phone self.options[:shipping_phone] unless self.options[:shipping_phone].blank?
                    xml.email self.options[:shipping_email] unless self.options[:shipping_email].blank?
                  }
                end
                xml.transactionDetail {
                  xml.payType {
                    xml.boleto {
                      xml.expirationDate self.options[:expiration_date]
                      xml.number self.options[:number]
                      xml.instructions self.options[:instructions] unless self.options[:instructions].blank?
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
        builder.to_xml(:indent => 2)
      end
  end
end
