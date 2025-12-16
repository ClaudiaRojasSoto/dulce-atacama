class Admin::PromotionsController < Admin::BaseController
  before_action :set_promotion, only: [:edit, :update, :destroy]
  
  def index
    @promotions = Promotion.all.order(created_at: :desc)
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    authorize @promotion
    
    if @promotion.save
      redirect_to admin_promotions_path, notice: "Promoción creada exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    authorize @promotion
    
    if @promotion.update(promotion_params)
      redirect_to admin_promotions_path, notice: "Promoción actualizada exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @promotion
    @promotion.destroy
    redirect_to admin_promotions_path, notice: "Promoción eliminada exitosamente."
  end
  
  private
  
  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
  
  def promotion_params
    params.require(:promotion).permit(:title, :description, :discount_percentage, :active, :valid_from, :valid_until)
  end
end
