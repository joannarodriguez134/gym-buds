class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :set_match, only: %i[ show edit update destroy ]
  before_action { authorize (@message || Message) }

  # GET /messages or /messages.json
  def index
    @match = Match.find(params[:match_id])
    # @messages = Message.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id).order(created_at: :desc)
    @messages = Message.for_user_in_accepted_matches(current_user.id).order(created_at: :desc)
  end

  # GET /messages/1 or /messages/1.json
  def show
    @match = Match.find(params[:match_id])
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @match = Match.find(params[:match_id])
    # Ensure the current user is part of the match before creating a message.
    @message = @match.messages.build(message_params.merge(sender_id: current_user.id))
  
    if @message.save
      redirect_to match_messages_path(@match), notice: 'Your changes have been saved.'
    else
      render :new
    end
  end
  

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  before_action :set_match, only: [:index, :new, :create, ...] # Add any actions that need @match

private

def set_match
  @match = Match.find(params[:match_id])
rescue ActiveRecord::RecordNotFound
  redirect_to(root_path, alert: "Match not found.")
end


  # Only allow a list of trusted parameters through.
  private
  def message_params
    params.require(:message).permit(:body)
  end
  
end
