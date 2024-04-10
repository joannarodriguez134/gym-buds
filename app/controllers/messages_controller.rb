class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :set_match, only: %i[create]
  before_action { authorize (@message || Message) }

  # GET /messages or /messages.json
  # def index
  #   @match = Match.find(params[:match_id])
  #   raw_messages = Message.for_user_in_accepted_matches(current_user.id).includes(:sender, :receiver).order(created_at: :desc)
  
  #   # This groups messages by the conversation partner, ensuring a unique list of users
  #   @messages_by_user = raw_messages.each_with_object({}) do |message, hash|
  #     other_user_id = message.sender_id == current_user.id ? message.receiver_id : message.sender_id
  #     hash[other_user_id] = message unless hash.key?(other_user_id)
  #   end
  # end  

 
    def index
      @match = Match.find(params[:match_id])
  
      @messages = @match.messages.order(created_at: :asc)
      @new_message = Message.new
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
    @message = @match.messages.build(message_params)
    @message.sender_id = current_user.id

     # Determine the receiver as the other user in the match
    @message.receiver_id = if @match.requester_id == current_user.id
      @match.approver_id
    else
      @match.requester_id
    end
    
    if @message.sender_id == @message.receiver_id
      redirect_to matches_path, alert: "Cannot send messages to yourself."
      return
    end
  
    if @match.status != 'accepted' || (@match.requester_id != current_user.id && @match.approver_id != current_user.id)
      redirect_to matches_path, alert: "Not authorized to send messages."
      return
    end
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to match_messages_path(@match), notice: "Message was successfully sent." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
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


  def set_match
    @match = Match.find(params[:match_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_path, alert: "Match not found.")
  end


  # Only allow a list of trusted parameters through.

  def message_params
    params.require(:message).permit(:body, :receiver_id)
  end
  
end
