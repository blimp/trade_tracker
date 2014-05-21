module TradeTracker
  module Concerns
    module Conversion
      extend ActiveSupport::Concern
      attr_reader :conversion_image_parameters

      included do
        helper_method :conversion_image_tag
      end

      def conversion_image_tag
        parameters = default_parameters.merge conversion_image_parameters
        url = tradetracker_conversion_path parameters
        ('<img src="%s" width="1" height="1" border="0" alt="" />' % url).html_safe
      end

      def send_conversion_to_tradetracker
        redirect_to tradetracker_conversion.trackback_url
      end

      def set_conversion_image_parameters(parameters = {})
        @conversion_image_parameters = parameters
      end

      private

      def default_parameters
        {
          use_https: tradetracker_conversion.use_https,
          campaign_id: tradetracker_conversion.campaign_id,
          product_id: tradetracker_conversion.product_id,
          conversion_type: tradetracker_conversion.conversion_type,
          transaction_id: tradetracker_conversion.transaction_id,
          transaction_amount: tradetracker_conversion.transaction_amount,
          email: tradetracker_conversion.email,
          quantity: tradetracker_conversion.quantity,
          merchant_description: tradetracker_conversion.merchant_description,
          affiliate_description: tradetracker_conversion.affiliate_description
        }
      end

      def tradetracker_conversion
        config = YAML.load_file('config/trade_tracker.yml')[Rails.env].symbolize_keys
        @conversion ||= TradeTracker::Conversion.new params, config
      end
    end
  end
end
