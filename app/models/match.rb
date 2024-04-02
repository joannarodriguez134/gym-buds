# == Schema Information
#
# Table name: matches
#
#  id           :bigint           not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  approver_id  :bigint           not null
#  requester_id :bigint           not null
#
# Indexes
#
#  index_matches_on_approver_id   (approver_id)
#  index_matches_on_requester_id  (requester_id)
#
# Foreign Keys
#
#  fk_rails_...  (approver_id => users.id)
#  fk_rails_...  (requester_id => users.id)
#
class Match < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :approver, class_name: "User"

  has_many :messages

  # Scope for accepted matches
  scope :accepted, -> { where(status: 'accepted') }

  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }

  validate :valid_status_transition, on: :update


  # Scopes
  scope :pending, -> { where(status: :pending) }
  scope :accepted, -> { where(status: :accepted) }
  scope :rejected, -> { where(status: :rejected) }

  # Scopes for matches involving a specific user
  scope :involving, ->(user) { where("requester_id = ? OR approver_id = ?", user.id, user.id) }

  # Scope for rejected matches by a specific user, regardless of being the requester or approver
  scope :rejected_by, ->(user) { rejected.where("requester_id = ? OR approver_id = ?", user.id, user.id) }

  # Scopes for matches where the user is the requester or approver specifically
  scope :requested_by, ->(user) { where(requester: user) }
  scope :approved_by, ->(user) { where(approver: user) }

  private

  def valid_status_transition
    if status_changed? && status_was == 'rejected'
      errors.add(:status, "can't transition from rejected")
    elsif status == 'accepted' && status_was != 'pending'
      errors.add(:status, "can only be accepted from pending state")
    end
  end

end
