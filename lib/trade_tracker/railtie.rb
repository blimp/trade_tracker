module TradeTracker
  class Railtie < Rails::Railtie
    initializer 'concerns.autoload', before: :set_autoload_paths do |app|
      tt_root = File.dirname __FILE__
      app.config.autoload_paths << File.join(tt_root, 'controllers', 'concerns')
    end
  end
end
