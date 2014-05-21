require 'rails/generators/base'

module TradeTracker
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'generate yaml config for TradeTracker campaign_id and product_id'

    def copy_files
      say_status '', "Copying configuration file... \n", :blue
      copy_file 'trade_tracker.yml', 'config/trade_tracker.yml'
    end

    def print_manual
      say_status 'OK', 'Done.', :green
      say "\nRemember to fill in your campaign_id and product_id in config/trade_tracker.yml", :yellow
      say "Further implementation details can be found at http://github.com/blimp/trade_tracker\n", :yellow
    end
  end
end
