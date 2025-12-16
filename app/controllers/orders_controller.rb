class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]
  
  def index
    @orders = policy_scope(Order).recent.includes(:order_items, :products)
  end

  def show
    authorize @order
  end

  def new
    @order = Order.new
    @order.order_items.build
    @products = Product.active.includes(:category)
  end

  def create
    @order = current_user.orders.build(order_params)
    authorize @order
    
    if @order.save
      send_whatsapp_notification(@order)
      redirect_to @order, notice: "Pedido creado exitosamente. Nos pondremos en contacto contigo pronto."
    else
      @products = Product.active.includes(:category)
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(
      :delivery_address, :delivery_date, :phone, :notes,
      order_items_attributes: [:id, :product_id, :quantity, :_destroy]
    )
  end
  
  def send_whatsapp_notification(order)
    phone_number = "56999999999"
    message = order.whatsapp_message
    whatsapp_url = "https://api.whatsapp.com/send?phone=#{phone_number}&text=#{ERB::Util.url_encode(message)}"
  end
end
