class AddPriceToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :total, :decimal, precision: 8, scale: 2
  end
end
