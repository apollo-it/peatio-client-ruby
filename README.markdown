Ruby client for Peatio API
==========================

[![Build Status](https://travis-ci.org/peatio/peatio-client-ruby.png?branch=master)](https://travis-ci.org/peatio/peatio-client-ruby)

`peatio-client-ruby` is a client for Peatio API, support all Peatio API functions like submit order, get tickers, etc. It's also a reference client implementation, where you can find how to authenticate private Peatio API.

### Requirements ###

* ruby 2.0.0 or higher (if you want to run 'rake test' in this gem you'll need ruby 2.1.0 or higher)
* openssl

### Install ###

    gem install peatio_client

### Usage ###

#### Command line tool ####

TBD

#### Library ####

Use `#get` or `#post` to access API after you created a `PeatioAPI::Client`:

```ruby
  require 'peatio_client'

  # initialize client. `endpoint` can be ignored
  client = PeatioAPI::Client.new access_key: 'your_access_key', secret_key: 'your_secret_key', endpoint: 'https://peatio.com'

  # GET public api /api/v2/markets
  client.get '/api/v2/markets'

  # GET private api /api/v2/orders with 'market=btccny'
  client.get '/api/v2/orders', market: 'btccny'

  # POST to create an order
  client.post '/api/v2/orders', market: 'btccny', side: 'sell', volume: '0.11', price: '2955.0'

  # POST to create multiple orders at once
  client.post '/api/v2/orders/multi', market: 'btccny', orders: [{side: 'buy', volume: '0.15', price: '2955.0'}, {side: 'sell', volume: '0.16', price: '2956'}]
```

Check [Peatio API v2 Documents](https://peatio.com/documents/api_v2) for details on Peatio API.

### License ###

`peatio-client-ruby` is released under MIT license. See [http://peatio.mit-license.org](http://peatio.mit-license.org) for more information.

### How To Contribute ###

Just create an issue or open a pull request :)
