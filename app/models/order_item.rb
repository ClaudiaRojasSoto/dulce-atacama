class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  before_validation :set_price
  
  def subtotal
    quantity * price
  end
  
  private
  
  def set_price
    self.price = product.price if product
  end
end
