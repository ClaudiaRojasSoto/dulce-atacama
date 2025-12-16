class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update, :destroy]
  
  def index
    @products = Product.all.includes(:category).order(created_at: :desc)
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    
    if @product.save
      redirect_to admin_products_path, notice: "Producto creado exitosamente."
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    authorize @product
    
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Producto actualizado exitosamente."
    else
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to admin_products_path, notice: "Producto eliminado exitosamente."
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :active, images: [])
  end
end
