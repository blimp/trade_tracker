require 'active_support/dependencies'
require "trade_tracker/version"
require 'trade_tracker/click'
require 'trade_tracker/conversion'
require 'trade_tracker/concerns/click.rb'
require 'trade_tracker/concerns/conversion.rb'

module TradeTracker
  include ActiveSupport::Dependencies
end
