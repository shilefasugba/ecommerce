class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def authenticate_admin_user!
    redirect_to root_url unless current_user.try(:admin?)
  end
end
