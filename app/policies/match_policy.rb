class MatchPolicy
  attr_reader :user, :match

  def initialize(user, match)
    @user = user
    @match = match
  end

  def index?
    user.present?
  end

  def show?
    match_belongs_to_user?
  end

  def create?
    user.present?
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
    match_belongs_to_user?
  end

  # Assuming like? and reject? actions might have their own authorization logic
  def like?
    # For now, any user can like as long as they exist
    user.present?
  end

  def reject?
    # Similarly, any user can reject as long as they exist
    user.present?
  end

  private

  def match_belongs_to_user?
    match.requester_id == user.id || match.approver_id == user.id
  end
end
