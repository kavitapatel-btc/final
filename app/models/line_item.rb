class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  #belongs_to :order

  #has_and_belongs_to_many :order
  def total_price
    product.price * quantity
  end
end
