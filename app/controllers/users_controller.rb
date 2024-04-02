class UsersController < ApplicationController
  before_action :set_user
  before_action { authorize @user || User }
  
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end
  
  def edit
  end

  def index
    @users = User.all
  end

  private


  # these represent all the fields that will be saved when a user creates an account
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :first_name, :last_name, :bio, :dob, :gender, :user_gym_frequency, :workouts, :avatar, :time_of_day, :skill_level, ideal_match_genders: [])
  end

  def set_user
    if params[:username]
      @user = User.find_by!(username: params.fetch(:username))
    else
      @user = current_user
    end
  end
end
