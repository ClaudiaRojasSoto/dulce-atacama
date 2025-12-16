class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, admin: 1 }
  
  has_many :orders, dependent: :destroy
  
  validates :role, presence: true
  validates :phone, presence: true, format: { with: /\A\+?[0-9\s\-()]+\z/, message: "formato inválido" }
  validates :full_name, presence: true, length: { minimum: 2 }
  
  after_initialize :set_default_role, if: :new_record?
  
  # Método para verificar si el usuario puede hacer pedidos
  def can_place_orders?
    phone_verified? && email_verified?
  end
  
  # Método para verificar si el perfil está completo
  def profile_complete?
    phone.present? && full_name.present? && email.present?
  end
  
  private
  
  def set_default_role
    self.role ||= :customer
  end
end
