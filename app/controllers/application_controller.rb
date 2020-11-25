class ApplicationController < ActionController::Base

  # >>> Uncomment for whitelist approach
  # before_action :authenticate_user!

  # Adding first name and last name upon registration
  before_action :set_navbar_visible

  before_action :configure_permitted_parameters, if: :devise_controller?


    def after_sign_in_path_for(resource)
    # return the path based on resource
      dashboard_path
    end

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
