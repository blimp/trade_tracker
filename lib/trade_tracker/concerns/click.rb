module TradeTracker
  module Concerns
    module Click
      extend ActiveSupport::Concern

      def send_click_to_tradetracker(redirect_options = {})
        if tradetracker_click.trackback_url
          redirect_to tradetracker_click.trackback_url, redirect_options
        else
          redirect_to root_path
        end
      end

      private

      def tradetracker_click
        @click ||= TradeTracker::Click.new params
      end

      def set_cookies
        # Apparently we need both a session/regular cookies, both with the same name/value
        cookies[tradetracker_click.cookie_name] = {
          value: tradetracker_click.cookie_value,
          expires: Time.now + 31536000,
          domain: request.host
        }
        session[tradetracker_click.cookie_name] = tradetracker_click.cookie_value
      end

      def set_p3p_header
        response.headers['P3P'] = 'CP="ALL PUR DSP CUR ADMi DEVi CONi OUR COR IND"'
      end
    end
  end
end
