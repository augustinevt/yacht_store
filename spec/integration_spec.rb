require('spec_helper')

describe "user experience", {type: :feature} do
  it 'should create a new purchase object and display list of products' do
    visit('/')
    click_on('New Cart')
    expect(page).to have_content('Super Yacht Surplus')
  end

  it 'should have a user view a specific product' do
    test_purchase = Purchase.create()
    test_product = Product.create(name: "SuperYacht 2000", price: 344.00, sold: false)
    visit("/purchase/#{test_purchase.id()}/products")
    click_on("#{test_product.name()}")
    expect(page).to have_content("#{test_product.name()}")
  end

  it 'should add selected products to purchase and show checkout page' do
    test_purchase = Purchase.create()
    test_product1 = Product.create(name: "SuperYacht 2000", price: 344.00, sold: false)
    test_product2 = Product.create(name: "SuperYacht 3000", price: 344.00, sold: false)
    test_product3 = Product.create(name: "SuperYacht XXL", price: 344.00, sold: false)
    visit("/purchase/#{test_purchase.id()}/products")
    click_on("#{test_product1.id()}")
    click_on("#{test_product2.id()}")

    # click_on('Checkout')
    # expect(page).to have_content('Your Order')
  end
end

describe "admin experience", {type: :feature} do
  it 'should create a new product' do
    visit("/admin")
    expect(page).to have_content("Add a Product to Your Store")
    fill_in("name", :with => "SuperYacht 2000")
    fill_in("price", :with => "250.00")
    click_on("Add Product")
    expect(page).to have_content("SuperYacht 2000")
  end
end
