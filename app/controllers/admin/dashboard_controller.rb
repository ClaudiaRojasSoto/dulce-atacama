class Admin::DashboardController < Admin::BaseController
  def index
    @total_orders = Order.count
    @pending_orders = Order.pending.count
    @total_products = Product.count
    @total_customers = User.customer.count
    @recent_orders = Order.recent.limit(10).includes(:user)
  end
end
