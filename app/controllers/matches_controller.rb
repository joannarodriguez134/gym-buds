class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy ]
  before_action :ensure_current_user_is_owner, only: [:destroy, :update, :edit]
  before_action :ensure_user_is_authorized, only: [:show]

  before_action { authorize (@match || Match )}

  # GET /matches or /matches.json
  def index
    raw_matches = Match.accepted.where("requester_id = ? OR approver_id = ?", current_user.id, current_user.id)
    
    unique_match_ids = raw_matches.each_with_object(Set.new) do |match, unique_matches|
      pair = [match.requester_id, match.approver_id].sort
      unique_matches.add(pair)
    end
    
    @matches = raw_matches.select do |match|
      match_pair = [match.requester_id, match.approver_id].sort
      unique_match_ids.include?(match_pair)
    end.uniq { |m| [m.requester_id, m.approver_id].sort }
  end
  
  

  # GET /matches/1 or /matches/1.json
  def show
    # only show the accepted matches
    @matches = Match.where(status: 'accepted').where("requester_id = ? OR approver_id = ?", @user.id, @user.id)
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches or /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to match_url(@match), notice: "Match was successfully created." }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to match_url(@match), notice: "Match was successfully updated." }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url, notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def like
    target_user = User.find_by!(username: params[:username])
    # The logic for finding or creating the match remains the same.
    existing_match = Match.find_or_initialize_by(requester: current_user, approver: target_user) do |match|
      match.status = 'pending'
    end
    
    if existing_match.persisted? && existing_match.pending?
      existing_match.update(status: 'accepted')
    elsif !existing_match.persisted?
      existing_match.save
    end
  
    # Redirect or respond accordingly
  end
  
  

  def reject
    target_user = User.find_by!(username: params[:username])
    existing_match = Match.find_by(requester: current_user, approver: target_user) ||
                     Match.find_by(requester: target_user, approver: current_user)
  
    if existing_match
      existing_match.update(status: 'rejected')
    end
  
    # Redirect or respond accordingly
  end
  

  private
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.require(:match).permit(:status, :requester_id, :approver_id)
    end

    def ensure_current_user_is_owner
      if current_user != (@match.requester || @match.approver)
        redirect_back fallback_location: root_url, alert: "You're not authorized for that."
      end
    end

    def ensure_user_is_authorized
      if !MatchPolicy.new(current_user, @match).show?
        redirect_back fallback_location: root_url
      end
    end
end
