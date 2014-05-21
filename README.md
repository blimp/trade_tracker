# TradeTracker

This gem is for you if you're looking to integrate TradeTracker click/conversion tracking into your Rails app.

This assumes basic knowledge of the TradeTracker tool.  
Refer to the official documentation if you have questions on the click/conversion process.

## Installation

Add this line to your application's Gemfile:

    gem 'trade_tracker', git: 'git@github.com:blimp/trade_tracker.git', branch: :master

And then execute:

    $ bundle
    $ 

## Usage

### 1. Setup two routes
```ruby
  get 'my_click_page' => 'tradetracker#index'
  get 'my_conversion_page' => 'tradetracker#conversion'
```
### 2. Create a basic controller (or map to your own)
```ruby
class TradetrackerController < ApplicationController
  include TradeTracker::Concerns::Click
  include TradeTracker::Concerns::Conversion

  def index
    set_p3p_header # Can comment out at will. It's still in the TT integration specs.
    set_cookies # Stores the required cookie hash so TT knows we're legit.
    send_click_to_tradetracker # Redirects to TTs trackback URL, and back to your redirect URL.
  end

  def conversion
    send_conversion_to_tradetracker # Redirects to TTs trackback_URL
  end
end
```
### 3. Add the conversion image tag
```ruby
# app/controllers/my_fancy_conversion_page_controller.rb:
class MyFancyConversionPageController < ApplicationController
  include TradeTracker::Concerns::Conversion

  def my_fancy_action
    set_conversion_image_parameters(
      transaction_id: @order_id,
      price: @total_price,
      merchant_description: "#{@configuration.id}-#{@property.name}",
      email: session[:booking_email],
      conversion_type: 'sales'
    )
  end
end
```
```ruby
# app/views/my_fancy_action.html.erb
<%= conversion_image_tag %>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/trade_tracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
