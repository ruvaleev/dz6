class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :conf, if: :devise_controller?

  private

  def conf
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
