require 'active_support/concern'

module TradeTracker
  module Concerns
    module Conversion
      extend ActiveSupport::Concern
      attr_reader :conversion_image_parameters

      def conversion_image_tag(parameters)
        ('<img src="%s" width="1" height="1" border="0" alt="" />' % params_to_url(parameters)).html_safe
      end

      def params_to_url(parameters)
        config = YAML.load_file('config/trade_tracker.yml')[Rails.env].symbolize_keys
        "https://"\
          "#{parameters[:conversion_type] == 'lead' ? 'tl' : 'ts'}."\
          "tradetracker.net/?cid=#{config[:campaign_id]}&"\
          "pid=#{config[:product_id]}&"\
          "data=#{parameters[:tracking_data]}&"\
          "type=#{parameters[:tracking_type]}&"\
          "tid=#{parameters[:transaction_id]}&"\
          "tam=#{parameters[:transaction_amount]}&"\
          "qty=#{parameters[:quantity]}&"\
          "eml=#{parameters[:email]}&"\
          "descrMerchant=#{parameters[:merchant_description]}&"\
          "descrAffiliate=#{parameters[:affiliate_description]}&"\
          "currency=#{parameters[:currency]}"
      end
    end
  end
end
