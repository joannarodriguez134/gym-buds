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
end
