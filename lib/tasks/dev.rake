unless Rails.env.production?
  namespace :dev do
    desc "Drops, creates, migrates, and adds sample data to database"
    task reset: [:environment, "db:drop", "db:create", "db:migrate", "dev:sample_data"]

    desc "Adds sample data for development environment"
    task sample_data: [:environment, "dev:add_users", "dev:add_matches", "dev:add_messages"] do
      puts "done adding sample data"
    end

    task add_users: :environment do
      puts "adding users..."
      names = ["britney", "carl", "danny", "mark", "mike", "lily", "adam"]

      names.each do |name|
        u = User.create(email: "#{name}@example.com", password: "password")
        puts "added #{u.email}"
      end

      puts "done"
    end

    task add_matches: :environment do
      puts "adding matches"

      statuses = ['pending', 'accepted', 'pending']

      25.times do |_i|
        approver = User.all.sample
        requester = User.where.not(id: approver.id).sample # Avoid the same user
        Match.create(approver: approver, requester: requester, status: statuses.sample)
      end
      puts "done"
    end

    task add_messages: :environment do
      puts "adding messages"
      Match.all.each do |match|
        rand(1..5).times do |_i|
          Message.create(
            match: match,
            sender_id: [match.requester_id, match.approver_id].sample,
            receiver_id: [match.requester_id, match.approver_id].sample,
            body: Faker::TvShows::BigBangTheory.quote # Ensure this matches your column name
          )
        end
      end
      puts "done"
    end
  end
end
