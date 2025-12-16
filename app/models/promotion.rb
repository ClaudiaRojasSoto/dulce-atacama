class Promotion < ApplicationRecord
  validates :title, presence: true
  validates :discount_percentage, presence: true, 
            numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :active, inclusion: { in: [true, false] }
  
  scope :active, -> { where(active: true) }
  scope :current, -> { where('valid_from <= ? AND valid_until >= ?', Date.current, Date.current) }
end
