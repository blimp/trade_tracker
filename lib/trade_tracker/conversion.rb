module TradeTracker
  class Conversion
    PARAMETERS = %w(use_https campaign_id product_id conversion_type tracking_data
                tracking_type transaction_id transaction_amount quantity
                email merchant_description affiliate_description)

    def initialize(params, config = nil)
      PARAMETERS.each do |p|
        values = config && config.include?(p.to_sym) ? config : params
        self.send "#{p}=", values[p.to_sym]

        unless self.respond_to?(p)
          self.class.send(:define_method, p, lambda {
            instance_variable_get('@' + p)
          })
        end
      end
    end

    def campaign_id=(value)
      @campaign_id = value.to_s
    end

    def product_id=(value)
      @product_id = value.to_s
    end

    def conversion_type=(value)
      @conversion_type = value.to_s
    end

    def use_https
      @use_https == 1
    end

    def use_https=(value)
      @use_https = value.to_i
    end

    def tracking_data=(value)
      @tracking_data = CGI.escape value.to_s
    end

    def tracking_type=(value)
      @tracking_type = value.to_s
    end

    def transaction_id=(value)
      @transaction_id = value.to_s
    end

    def transaction_amount=(value)
      @transaction_amount = value.to_f
    end

    def quantity=(value)
      @quantity = CGI.escape value.to_s
    end

    def email=(value)
      @email = CGI.escape value.to_s
    end

    def merchant_description=(value)
      @merchant_description = CGI.escape value.to_s
    end

    def affiliate_description=(value)
      @affiliate_description = CGI.escape value.to_s
    end

    def trackback_url
      if campaign_id.blank? || product_id.blank?
        raise 'Wrong or missing parameters'
      else
        "#{use_https ? 'https' : 'http'}://#{conversion_type == 'lead' ? 'tl' : 'ts'}.tradetracker.net/?cid=#{campaign_id}&pid=#{product_id}&data=#{tracking_data}&type=#{tracking_type}&tid=#{transaction_id}&tam=#{transaction_amount}&qty=#{quantity}&eml=#{email}&descrMerchant=#{merchant_description}&descrAffiliate=#{affiliate_description}"
      end
    end

    def cookie_name
      "TT2_#{campaign_id}"
    end
  end
end
