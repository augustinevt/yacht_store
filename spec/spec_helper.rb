ENV['RACK_ENV'] = 'test'

require("sinatra/activerecord")
require('rspec')
require('pg')
require('product')
require('purchase')

RSpec.configure do |config|
  config.before(:each) do
    Product.all().each() do |product|
      product.destroy()
    end
    Purchase.all().each() do |purchase|
      purchase.destroy()
    end
  end
  config.after(:each) do
    Product.all().each() do |product|
      product.destroy()
    end
    Purchase.all().each() do |purchase|
      purchase.destroy()
    end
  end
end
