class ApplicationController < ActionController::Base

  # >>> Uncomment for whitelist approach
  # before_action :authenticate_user!

  # Adding first name and last name upon registration
  before_action :set_navbar_visible

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :location])
  end

  def set_navbar_visible

    @navbar_visible = true
  end
end
