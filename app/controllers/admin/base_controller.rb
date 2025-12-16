class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  
  layout "admin"
  
  private
  
  def verify_admin
    unless current_user.admin?
      redirect_to root_path, alert: "No tienes permisos para acceder a esta sección."
    end
  end
end

