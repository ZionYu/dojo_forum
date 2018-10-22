class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def purview_check(post, current_user)
    if post.purview == 'All' ||
       post.purview == 'Friend' && current_user.friend?(post.user) == 'friend' ||
       post.user == current_user
    else
      redirect_back(fallback_location: root_path)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
