class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def complete_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    
    if @user.update(profile_params)
      flash[:notice] = "✅ Perfil actualizado correctamente. Ahora puedes hacer pedidos una vez que verifiquemos tu información."
      redirect_to root_path
    else
      flash.now[:alert] = "❌ No se pudo actualizar el perfil. Por favor verifica los datos."
      render :complete_profile
    end
  end

  private

  def profile_params
    params.require(:user).permit(:full_name, :phone)
  end
end
