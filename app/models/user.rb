class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, admin: 1 }
  
  has_many :orders, dependent: :destroy
  
  validates :role, presence: true
  
  after_initialize :set_default_role, if: :new_record?
  
  private
  
  def set_default_role
    self.role ||= :customer
  end
end
