class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  private


  # these represent all the fields that will be saved when a user creates an account
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :first_name, :last_name, :bio, :dob, :gender, :user_gym_frequency, :workouts, :avatar, :time_of_day, :skill_level, ideal_match_genders: [])
  end
end
