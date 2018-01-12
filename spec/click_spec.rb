require 'trade_tracker'

describe TradeTracker::Click do
  subject do
    TradeTracker::Click.new(
      campaignID: '14986',
      material_id: '0',
      affiliate_id: '18897',
      reference: '',
      r: 'http://www.google.be'
    )
  end

  describe '#campaign_id' do
    it 'result' do
      subject.campaign_id = 1234
      expect(subject.campaign_id).to eq '1234'
    end

    it 'blank' do
      subject.campaign_id = 0
      expect(subject.campaign_id).to eq '0'
    end
  end

  describe '#affiliate_id' do
    it 'result' do
      subject.affiliate_id = 1234
      expect(subject.affiliate_id).to eq '1234'
    end

    it 'blank' do
      subject.affiliate_id = 0
      expect(subject.affiliate_id).to eq '0'
    end
  end

  describe '#material_id' do
    it 'result' do
      subject.material_id = 20
      expect(subject.material_id).to eq '20'
    end

    it 'blank' do
      subject.material_id = 0
      expect(subject.material_id).to eq '0'
    end
  end

  describe '#redirect_url' do
    it 'filled' do
      subject.redirect_url = 'http://www.google.be'
      expect(subject.redirect_url).to eq 'http%3A%2F%2Fwww.google.be'
    end

    it 'blank' do
      subject.redirect_url = nil
      expect(subject.redirect_url).to eq ''
    end
  end

  describe '#reference' do
    it 'filled' do
      subject.reference = 'X254'
      expect(subject.reference).to eq 'X254'
    end

    it 'blank' do
      subject.reference = nil
      expect(subject.reference).to eq ''
    end
  end

  it '#cookie_name' do
    subject.campaign_id = 'foo'
    expect(subject.cookie_name).to eq 'TT2_foo'
  end

  it '#cookie_value' do
    expect(subject.cookie_value).to include '0::18897::::c83b23df3e4be73b2aa751dbd2fc248e::'
  end

  it '#trackback_url' do
    expect(subject.trackback_url).to eq 'http://tc.tradetracker.net/?c=14986&m=0&a=18897&r=&u='
  end

  it '#respond_to?' do
    expect(subject).to respond_to(
      :campaign_id=, :campaign_id, :material_id=, :material_id, :affiliate_id=,
      :affiliate_id, :reference=, :reference, :redirect_url=, :redirect_url,
      :cookie_name, :cookie_value, :trackback_url
    )
  end
end
