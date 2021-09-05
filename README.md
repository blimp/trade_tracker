# TradeTracker on Rails

This gem is for you if you're looking to integrate TradeTracker click/conversion tracking into your Rails app.

TradeTracker has two functionalities: click and conversion. 

- Click - give info to tradetracker from what affiliate just got redirected. 
To have this functionality, you only need to put route in routes and after that only inform staff from trade tracker site.

- Conversion - give info to tradetracker about product purchased. To have this functionality, you need to put helper method inside thank-you page or after-purchase view. 
After that a little image (1px to 1px) will be created. Instead of showing something using url, it will send info to tradetracker about products using this url. 

Refer to the official documentation if you have questions on the click/conversion process.

## Installation

Add this line to your application's Gemfile:

    gem 'trade_tracker', '~> 0.2.3'

Then execute:

    $ bundle

And finally, generate your configuration file:

    $ rails g trade_tracker:config

## Usage

### 1. Setup two routes
```ruby
  get 'my_click_page' => 'tradetracker#index'
```
Name the second route "tradetracker_conversion" (see example above), as it is used by the gem to lookup the path to the conversion pixel.
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
end
```
### 3. Add the helper method with function conversion_image_tag inside
```ruby
# app/controllers/whatever_controller_you_want.rb:
class WhateverControllerYouWantController < ApplicationController
  helper_method :conversion_tag

  def conversion_tag
    # Refer to the TradeTracker documentation to see which params are available.
    set_conversion_image_parameters(
      conversion_type: 'sales',
      merchant_description: "Describe what you sold (IDs/names/...)",
      email: 'customer@bought.it',
    )
  end
end
```
```erb
# app/views/my_fancy_action.html.erb
<%= conversion_image_tag %>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/trade_tracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
