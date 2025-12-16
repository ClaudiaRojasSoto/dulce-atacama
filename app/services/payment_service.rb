class PaymentService
  def initialize(order)
    @order = order
  end

  def create_payment_intent
    Stripe::PaymentIntent.create(
      amount: calculate_amount,
      currency: 'clp',
      metadata: {
        order_id: @order.id,
        user_email: @order.user.email
      }
    )
  rescue Stripe::StripeError => e
    Rails.logger.error "Stripe error: #{e.message}"
    nil
  end

  def process_payment(payment_method_id)
    intent = create_payment_intent
    return false unless intent

    Stripe::PaymentIntent.confirm(
      intent.id,
      payment_method: payment_method_id
    )
    
    true
  rescue Stripe::StripeError => e
    Rails.logger.error "Payment processing error: #{e.message}"
    false
  end

  private

  def calculate_amount
    (@order.total * 100).to_i
  end
end

