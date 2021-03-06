class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected
  def after_sign_in_path_for(resource)
  	# here i make the request to the waybook api

    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end
