class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:edit, :update, :destroy]
  
  def index
    @categories = Category.all.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    
    if @category.save
      redirect_to admin_categories_path, notice: "Categoría creada exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    authorize @category
    
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Categoría actualizada exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @category
    @category.destroy
    redirect_to admin_categories_path, notice: "Categoría eliminada exitosamente."
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
