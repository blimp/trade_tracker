require 'trade_tracker'

describe TradeTracker::Concerns::Click do
  include described_class

  describe '#send_click_to_tradetracker' do
    let(:click) { TradeTracker::Click.new(tt: '14986_12_157365_') }

    before do
      allow(self).to receive(:tradetracker_click) { click }
      allow(self).to receive(:redirect_to)
    end

    it 'redirects to a tradetracker URL by default' do
      expect(self).to receive(:redirect_to).with('http://tc.tradetracker.net/?c=14986&m=12&a=157365&r=&u=', {})
      send_click_to_tradetracker
    end

    it 'passes redirect_options parameter to redirect_to' do
      expect(self).to receive(:redirect_to).with('http://tc.tradetracker.net/?c=14986&m=12&a=157365&r=&u=', status: 301)
      send_click_to_tradetracker(status: 301)
    end
  end
end
