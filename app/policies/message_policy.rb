class MessagePolicy
  attr_reader :user, :message

  def initialize(user, message)
    @user = user
    @message = message
  end

  def index?
    user.present?
  end

  def show?
    match_belongs_to_user?
  end

  def create?

    return false unless user.present?
  
    match = Match.accepted_between(user.id, message.receiver_id)
    
    match.present?
  end

  def new?
    create?
  end

  def update?
    match_belongs_to_user?
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end


private

def match_belongs_to_user?
  # Assuming message.receiver_id is available
  match = Match.accepted_between(user.id, message.receiver_id)
  match && (match.requester_id == user.id || match.approver_id == user.id)
  end
end
