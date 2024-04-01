class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_params
    params.require(:user).permit(ideal_match_gender: [])
  end
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :dob, :email, :gender, :gym_frequency_category, :ideal_match_gender, :skill_level, :time_of_day, :type_of_workouts, :user_gym, :username, :avatar])
  end
end
