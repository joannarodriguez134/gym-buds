module UserRelationships
  extend ActiveSupport::Concern
  # probably better to keep this in user.rb
  included do
    has_one_attached :avatar
    # Naming could be more explicit
    has_one_attached :additional_files
    has_one_attached :additional_files_2
    has_one_attached :additional_files_3

    has_many :matches, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :requested_matches, class_name: "Match", foreign_key: "requester_id", dependent: :destroy
    has_many :approved_matches, class_name: "Match", foreign_key: "approver_id", dependent: :destroy
    has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
    has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy
  end
end
