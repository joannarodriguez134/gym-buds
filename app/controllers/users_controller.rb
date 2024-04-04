class UsersController < ApplicationController
  before_action :set_user, only: [:messages]
  before_action { authorize @user || User }
  
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end
  
  def edit
  end

  def index
    # Get ids of users where there is an accepted match with the current user
    accepted_matches_user_ids = Match.where(status: 'accepted').where("requester_id = ? OR approver_id = ?", current_user.id, current_user.id).pluck(:requester_id, :approver_id).flatten.uniq
  
    # Exclude the current user and users with whom they have an accepted match
    @users = User.where.not(id: [current_user.id, *accepted_matches_user_ids])
  end

  def messages
    @user = User.find_by!(username: params[:username])
  
    # Fetch only matches with 'accepted' status involving the current user
    accepted_matches_ids = Match.where(status: 'accepted')
                                .where("requester_id = ? OR approver_id = ?", @user.id, @user.id)
                                .pluck(:id)
  
    # Fetch messages related to those matches where the user is either sender or receiver
    @messages = Message.includes(:sender, :receiver)
                        .where(match_id: accepted_matches_ids)
                        .where("sender_id = :user_id OR receiver_id = :user_id", user_id: @user.id)
                        .order(created_at: :desc)
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
