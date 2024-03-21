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

  enum status: { pending: 'pending', accepted: 'accepted', declined: 'declined' }
end
