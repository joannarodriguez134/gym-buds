class UsersController < ApplicationController
  before_action :set_user, only: [:messages]
  before_action :authorize_user, only: [:messages]
  before_action { authorize @user || User }
  
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end
  
  def edit
  end

  def index
    accepted_matches_user_ids = Match.where(status: "accepted").where("requester_id = ? OR approver_id = ?", current_user.id, current_user.id).pluck(:requester_id, :approver_id).flatten.uniq
  
    @users = User.where.not(id: [current_user.id, *accepted_matches_user_ids])
  end

  def messages
    @user = current_user
    
    matches = Match.where(status: "accepted").where("requester_id = :user_id OR approver_id = :user_id", user_id: @user.id)
    
    @messages = matches.map do |match|
      match.messages.order(updated_at: :desc).first
    end.compact 
  end
  
  
  

  private


  # these represent all the fields that will be saved when a user creates an account
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :first_name, :last_name, :bio, :dob, :gender, :user_gym_frequency, :workouts, :avatar, :time_of_day, :skill_level, :additional_files, :additional_files_2, :additional_files_3, ideal_match_genders: [])
  end

  def set_user
    if params[:username]
      @user = User.find_by!(username: params.fetch(:username))
    else
      @user = current_user
    end
  end

  def authorize_user
    unless current_user == @user
      redirect_to root_path, alert: "You are not authorized to view these messages."
    end
  end
end
