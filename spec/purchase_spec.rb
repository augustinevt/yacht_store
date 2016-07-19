require('spec_helper')

describe 'Purchase' do
  it 'add up total of associated product prices' do
    test_purchase = Purchase.create()
    test_product1 = Product.create(name: "SuperYacht 2000", price: 344.00, sold: false, purchase_id: test_purchase.id())
    test_product2 = Product.create(name: "SuperYacht 3000", price: 344.00, sold: false, purchase_id: test_purchase.id())
    test_product3 = Product.create(name: "SuperYacht XXL", price: 344.00, sold: false, purchase_id: test_purchase.id())

    expect(test_purchase.total).to eq 1032

  end
end
