json.extract! message, :id, :body, :match_id, :sender_id, :receiver_id, :created_at, :updated_at
json.url message_url(message, format: :json)
