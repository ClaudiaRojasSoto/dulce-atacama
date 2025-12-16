class HomeController < ApplicationController
  def index
    @featured_products = Product.active.limit(6)
    @active_promotions = Promotion.active.current
    @categories = Category.all
  end
end
