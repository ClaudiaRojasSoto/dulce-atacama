class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :restrict_with_error
  has_many_attached :images
  
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :active, inclusion: { in: [true, false] }
  
  scope :active, -> { where(active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
