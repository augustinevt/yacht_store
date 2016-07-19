class CreateProducts < ActiveRecord::Migration
  def change
    create_table(:products) do |t|
      t.string :name
      t.boolean :sold
      t.timestamps()
    end
    add_column :products, :price, :decimal, precision: 5, scale: 2
  end
end
