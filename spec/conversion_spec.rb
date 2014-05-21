require 'trade_tracker'

describe TradeTracker::Conversion do
  before(:each) do
    @tt = TradeTracker::Conversion.new(
      campaign_id: '14986',
      product_id: '22367',
      conversion_type: 'sales',
      use_https: '1'
    )
  end

  describe 'parameters' do
    it 'should filter campaign_id' do
      @tt.campaign_id = 1234
      @tt.campaign_id.should == '1234'

      @tt.campaign_id = 0
      @tt.campaign_id.should == '0'
    end

    it 'should filter product_id' do
      @tt.product_id = 20
      @tt.product_id.should == '20'

      @tt.product_id = 0
      @tt.product_id.should == '0'
    end

    it 'should filter conversion_type' do
      @tt.conversion_type = 1234
      @tt.conversion_type.should == '1234'

      @tt.conversion_type = 0
      @tt.conversion_type.should == '0'
    end

    it 'should filter https state' do
      @tt.use_https.should == true

      @tt.use_https = '0'
      @tt.use_https.should == false
    end

    it 'should filter transaction amount' do
      @tt.transaction_amount = '1234'
      @tt.transaction_amount.should == 1234.0

      @tt.transaction_amount = '405.76'
      @tt.transaction_amount.should == 405.76
    end
  end

  describe 'trackback_url' do
    it 'should raise an exception when no campaign ID is set' do
      @tt.campaign_id = nil
      expect { @tt.trackback_url }.to raise_error('Wrong or missing parameters')
    end

    it 'should raise an exception when no product ID is set' do
      @tt.product_id = nil
      expect { @tt.trackback_url }.to raise_error('Wrong or missing parameters')
    end

    it 'should return the correct trackback URL' do
      @tt.trackback_url.should == 'https://ts.tradetracker.net/?cid=14986&pid=22367&data=&type=&tid=&tam=0.0&qty=&eml=&descrMerchant=&descrAffiliate='
    end
  end

  it 'should respond to some methods' do
    @tt.should respond_to(
      :campaign_id=, :campaign_id, :product_id=, :product_id, :conversion_type=,
      :conversion_type, :use_https=, :use_https, :tracking_data=,
      :tracking_data, :transaction_id=, :transaction_id, :transaction_amount=,
      :transaction_amount, :quantity=, :quantity, :email=, :email,
      :merchant_description=, :merchant_description, :affiliate_description=,
      :affiliate_description, :trackback_url
    )
  end
end
