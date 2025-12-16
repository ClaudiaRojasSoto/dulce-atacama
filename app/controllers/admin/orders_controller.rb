class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :update]
  
  def index
    @orders = Order.all.includes(:user, :order_items).recent
    @orders = @orders.by_status(params[:status]) if params[:status].present?
  end

  def show
  end

  def update
    authorize @order
    
    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: "Pedido actualizado exitosamente."
    else
      render :show, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
end
