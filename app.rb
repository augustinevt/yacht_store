require("sinatra/activerecord")
require('sinatra')
require('sinatra/reloader')
require('./lib/product')
require('./lib/purchase')
require('pg')
require('pry')
also_reload('lib/**/*.rb')