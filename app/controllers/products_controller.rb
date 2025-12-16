class ProductsController < ApplicationController
  def index
    @products = Product.active.includes(:category)
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end
end
