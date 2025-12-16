class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :verify_phone, :confirm_email]
  
  def index
    @users = User.where(role: :customer).order(created_at: :desc)
    @pending_verification = @users.where(confirmed_at: nil).or(@users.where(phone_verified: false))
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Usuario actualizado exitosamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def confirm_email
    @user.confirm
    redirect_to admin_users_path, notice: "Email confirmado manualmente para #{@user.full_name}"
  end
  
  def verify_phone
    @user.update(phone_verified: true)
    redirect_to admin_users_path, notice: "Teléfono verificado exitosamente para #{@user.full_name}"
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:full_name, :email, :phone, :phone_verified)
  end
end

