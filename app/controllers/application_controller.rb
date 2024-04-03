class ApplicationController < ActionController::Base
  skip_forgery_protection
  include Pundit
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation, ideal_match_gender: [])
  # end
  
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :bio, :dob, :email, :gender, :gym_frequency_category, :skill_level, :time_of_day, :type_of_workouts, :user_gym, :username, :avatar, ideal_match_gender: []])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :dob, :email, :gender, :gym_frequency_category, :skill_level, :time_of_day, :type_of_workouts, :user_gym, :username, :avatar, ideal_match_gender: []])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    
    redirect_back(fallback_location: root_url)
  end

  
  
end
