class Purchase < ActiveRecord::Base
  has_many :products

  def calculate_total()
    self.products.inject(0) do |sum, product|
      sum + product.price()
    end
  end

def self.made_between(start_date, end_date)
  Purchase.where("created_at >= :start_date AND created_at <= :end_date",
    {start_date: start_date, end_date: end_date})
end

end
