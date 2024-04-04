# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  match_id    :bigint           not null
#  receiver_id :bigint           not null
#  sender_id   :bigint           not null
#
# Indexes
#
#  index_messages_on_match_id     (match_id)
#  index_messages_on_receiver_id  (receiver_id)
#  index_messages_on_sender_id    (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (receiver_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :match
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :body, presence: true

  # Scopes
  
  scope :for_match, ->(match_id) { where(match_id: match_id) }
  scope :from_user, ->(user_id) { where(sender_id: user_id) }
  scope :to_user, ->(user_id) { where(receiver_id: user_id) }

  # Retrieves messages for a given user that are part of accepted matches
  def self.for_user_in_accepted_matches(user_id)
    joins(:match)
      .where(matches: { status: 'accepted' })
      .where("messages.sender_id = ? OR messages.receiver_id = ?", user_id, user_id)
  end

  def self.accepted_between(user1_id, user2_id)
    accepted.where(requester_id: user1_id, approver_id: user2_id)
            .or(accepted.where(requester_id: user2_id, approver_id: user1_id))
  end

end
