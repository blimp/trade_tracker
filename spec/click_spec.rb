require 'trade_tracker'

describe TradeTracker::Click do
  before(:each) do
    @tt = TradeTracker::Click.new(
      campaignID: '14986',
      material_id: '0',
      affiliate_id: '18897',
      reference: '',
      r: 'http://www.google.be'
    )
  end

  describe 'parameters' do
    it 'should filter campaign_id' do
      @tt.campaign_id = 1234
      @tt.campaign_id.should == '1234'

      @tt.campaign_id = 0
      @tt.campaign_id.should == '0'
    end

    it 'should filter affiliate_id' do
      @tt.affiliate_id = 1234
      @tt.affiliate_id.should == '1234'

      @tt.affiliate_id = 0
      @tt.affiliate_id.should == '0'
    end

    it 'should filter material_id' do
      @tt.material_id = 20
      @tt.material_id.should == '20'

      @tt.material_id = 0
      @tt.material_id.should == '0'
    end

    it 'should filter an empty redirect_url' do
      @tt.redirect_url = 'http://www.google.be'
      @tt.redirect_url.should == 'http%3A%2F%2Fwww.google.be'

      @tt.redirect_url = nil
      @tt.redirect_url.should == ''
    end

    it 'should filter an empty reference' do
      @tt.reference = 'X254'
      @tt.reference.should == 'X254'

      @tt.reference = nil
      @tt.reference.should == ''
    end
  end

  it 'should return the correct cookie name' do
    @tt.campaign_id = 'foo'
    @tt.cookie_name.should == 'TT2_foo'
  end

  it 'should return the correct cookie value' do
    @tt.cookie_value.should include '0::18897::::c83b23df3e4be73b2aa751dbd2fc248e::'
  end

  describe 'trackback_url' do
    it 'should return the correct tradetracker trackback URL' do
      @tt.trackback_url.should == 'http://tc.tradetracker.net/?c=14986&m=0&a=18897&r=&u='
    end
  end

  it 'should respond to some methods' do
    @tt.should respond_to(
      :campaign_id=, :campaign_id, :material_id=, :material_id, :affiliate_id=,
      :affiliate_id, :reference=, :reference, :redirect_url=, :redirect_url,
      :cookie_name, :cookie_value, :trackback_url
    )
  end
end
