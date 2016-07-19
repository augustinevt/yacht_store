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
  @products = Product.all().order(name: :asc)
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
  @product = Product.find(params[:id])
  name = params.fetch("name", @product.name())
  price = params.fetch("price").to_f
  @product.update(name: name, price: price, sold: false)
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

get('/purchase') do
  if params
    Purchase.made_between(params[:start_date],params[:end_date])
  else
    @purchase = Purchase.create()
  end
  redirect "/purchase/#{@purchase.id()}/products"
end

get('/purchase/:id/products') do
  @products = Product.all()
  @purchase = Purchase.find(params[:id])
  erb(:products)
end

get('/purchase/:id') do
  @purchase = Purchase.find(params[:id])
  @products = @purchase.products()
  @total_cost = @purchase.calculate_total()
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
  if @product.purchase_id() == @purchase.id()
    @product.update(purchase_id: nil)
    redirect "/purchase/#{@purchase.id()}"
  else
    @product.update(purchase_id: @purchase.id())
    redirect "/purchase/#{@purchase.id()}/products"
  end
end

patch('/purchase/:purchase_id') do
  @purchase = Purchase.find(params[:purchase_id])
  @products = Purchase.all()
  total_cost = @purchase.calculate_total()
  @purchase.update(total: total_cost)
  erb(:order_confirmation)
end
