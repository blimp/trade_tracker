require 'digest/md5'

module TradeTracker
  class Click
    attr_reader :campaign_id, :material_id, :affiliate_id, :reference,
                :redirect_url

    def initialize(params)
      if params[:campaignID]
        self.campaign_id = params[:campaignID]
        self.material_id = params[:material_id]
        self.affiliate_id = params[:affiliate_id]
        self.redirect_url = params[:redirect_url]
      elsif params[:tt]
        tracking_data = params[:tt].split('_')

        self.campaign_id = tracking_data[0]
        self.material_id = tracking_data[1]
        self.affiliate_id = tracking_data[2]
        self.reference = tracking_data[3]
        self.redirect_url = params[:r]
      end
    end

    def campaign_id=(value)
      @campaign_id = value.to_s
    end

    def material_id=(value)
      @material_id = value.to_s
    end

    def affiliate_id=(value)
      @affiliate_id = value.to_s
    end

    def reference=(value)
      @reference = CGI.escape value.to_s
    end

    def redirect_url=(value)
      @redirect_url = CGI.escape value.to_s
    end

    def trackback_url
      if campaign_id.present? || affiliate_id.present?
        "https://tc.tradetracker.net/?c=#{campaign_id}&m=#{material_id}&a=#{affiliate_id}&r=#{reference}&u=#{redirect_url}"
      end
    end

    def cookie_name
      "TT2_#{campaign_id}"
    end

    def cookie_value
      "#{material_id}::#{affiliate_id}::#{reference}::#{checksum}::#{Time.now.to_i}"
    end

    private

    def checksum
      Digest::MD5.hexdigest(
        "CHK_#{campaign_id}::#{material_id}::#{affiliate_id}::#{reference}"
      )
    end
  end
end
