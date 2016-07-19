require("sinatra/activerecord")
require('sinatra')
require('sinatra/reloader')
require('./lib/product')
require('./lib/purchase')
require('pg')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end

get('/admin') do
  @products = Product.all()
  erb(:admin)
end

get('/products/:id') do
  @product = Product.find(params[:id])
  erb(:product_edit)
end

post("/products") do
  name = params.fetch("name")
  price = params.fetch("price").to_f
  @product = Product.create(name: name, price: price, sold: false)
  redirect "/admin"
end

patch("/products/:id") do
  name = params.fetch("name")
  price = params.fetch("price").to_f
  @product = Product.update(name: name, price: price, sold: false)
  redirect "/admin"
end

delete("/products/:id") do
  @product = Product.find(params[:id])
  @product.delete()
  @products = Product.all()
  redirect "/admin"
end

post('/purchase') do
  @purchase = Purchase.create()
  redirect "/purchase/#{@purchase.id()}/products"
end

get('/purchase/:id/products') do
  @products = Product.all()
  @purchase = Purchase.find(params[:id])
  erb(:products)
end

get('/purchase/:id') do
  @products = Product.all()
  @purchase = Purchase.find(params[:id])
  erb(:show_cart)
end

get('/purchase/:purchase_id/products/:id') do
  @purchase = Purchase.find(params[:purchase_id])
  @product = Product.find(params[:id])
  erb(:product)
end


patch('/purchase/:purchase_id/products/:id') do
  @purchase = Purchase.find(params[:purchase_id])
  @product = Product.find(params[:id])
  @product.update(purchase_id: @purchase.id())
  redirect "/purchase/#{@purchase.id()}/products"
end
