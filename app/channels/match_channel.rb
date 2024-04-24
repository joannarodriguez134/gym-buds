
# module ApplicationCable
#   class MatchChannel < ApplicationCable::Channel
#     def subscribed
#       stream_for current_user
#     end
#   end
# end

# module ApplicationCable
#   class MatchChannel < Channel
#     def subscribed
#       # "match_#{params[:match_id]}" constructs a unique channel for each match.
#       stream_from "match_#{params[:match_id]}"
#       stream_for current_user
#     end

#     def unsubscribed
#       # Any cleanup logic when channel is unsubscribed
#     end
#   end
# end
