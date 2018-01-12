require 'trade_tracker'

describe TradeTracker::Conversion do
  let(:instance) do
    TradeTracker::Conversion.new(
      campaign_id: '14986',
      product_id: '22367',
      conversion_type: 'sales',
      use_https: '1'
    )
  end

  describe '#campaign_id' do
    it 'result' do
      instance.campaign_id = 1234
      expect(instance.campaign_id).to eq '1234'
    end

    it 'blank' do
      instance.campaign_id = 0
      expect(instance.campaign_id).to eq '0'
    end
  end

  describe '#product_id' do
    it 'result' do
      instance.product_id = 20
      expect(instance.product_id).to eq '20'
    end

    it 'blank' do
      instance.product_id = 0
      expect(instance.product_id).to eq '0'
    end
  end

  describe '#conversion_type' do
    it 'result' do
      instance.conversion_type = 1234
      expect(instance.conversion_type).to eq '1234'
    end

    it 'blank' do
      instance.conversion_type = 0
      expect(instance.conversion_type).to eq '0'
    end
  end

  describe '#use_https' do
    it 'true' do
      expect(instance.use_https).to be true
    end

    it 'false' do
      instance.use_https = '0'
      expect(instance.use_https).to be false
    end
  end

  it '#transaction_amount' do
    instance.transaction_amount = '1234'
    expect(instance.transaction_amount).to eq 1234.0
  end

  describe '#trackback_url' do
    it 'no campaign ID' do
      instance.campaign_id = nil
      expect { instance.trackback_url }.to raise_error('Wrong or missing parameters')
    end

    it 'no product ID' do
      instance.product_id = nil
      expect { instance.trackback_url }.to raise_error('Wrong or missing parameters')
    end

    it 'result' do
      expect(instance.trackback_url).to eq 'https://ts.tradetracker.net/?cid=14986&pid=22367&data=&type=&tid=&tam=0.0&qty=&eml=&descrMerchant=&descrAffiliate='
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :campaign_id=, :campaign_id, :product_id=, :product_id, :conversion_type=,
      :conversion_type, :use_https=, :use_https, :tracking_data=,
      :tracking_data, :transaction_id=, :transaction_id, :transaction_amount=,
      :transaction_amount, :quantity=, :quantity, :email=, :email,
      :merchant_description=, :merchant_description, :affiliate_description=,
      :affiliate_description, :trackback_url
    )
  end
end
