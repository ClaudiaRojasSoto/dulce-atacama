class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank
  
  enum status: { pending: "pending", confirmed: "confirmed", preparing: "preparing", 
                 ready: "ready", delivered: "delivered", cancelled: "cancelled" }
  
  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :delivery_date, presence: true
  validates :phone, presence: true
  validates :delivery_address, presence: true
  
  validate :delivery_date_must_be_future
  validate :delivery_date_must_be_at_least_one_day_ahead
  
  before_validation :calculate_total
  after_initialize :set_default_status, if: :new_record?
  
  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) }
  
  def whatsapp_message
    message = "🍰 *Nuevo pedido - Dulce Atacama*\n\n"
    message += "👤 Cliente: #{user.email}\n"
    message += "📞 Teléfono: #{phone}\n"
    message += "📍 Dirección: #{delivery_address}\n"
    message += "📅 Fecha de entrega: #{delivery_date.strftime('%d/%m/%Y %H:%M')}\n\n"
    message += "🛒 *Productos:*\n"
    order_items.each do |item|
      message += "- #{item.quantity}x #{item.product.name} ($#{item.price})\n"
    end
    message += "\n💰 *Total: $#{total}*\n"
    message += "\n📝 Notas: #{notes}" if notes.present?
    message
  end
  
  private
  
  def set_default_status
    self.status ||= :pending
  end
  
  def calculate_total
    self.total = order_items.reject(&:marked_for_destruction?).sum(&:subtotal)
  end
  
  def delivery_date_must_be_future
    if delivery_date.present? && delivery_date < Time.current
      errors.add(:delivery_date, "debe ser en el futuro")
    end
  end
  
  def delivery_date_must_be_at_least_one_day_ahead
    if delivery_date.present? && delivery_date < 1.day.from_now
      errors.add(:delivery_date, "debe ser con al menos 24 horas de anticipación")
    end
  end
end
