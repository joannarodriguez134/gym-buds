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
      names = ["alice", "cameron", "chelsea", "nick", "danny", "sam", "jenny"]
      last_names = ["smith", "jones", "milan", "castillo"]
      genders = ['male', 'female', 'nonbinary']
      gym_frequencies = ['daily', 'twice_a_week', 'multiple_times_a_week', 'weekly', 'every_two_weeks', 'occasionally', 'rarely']
      ideal_match_genders = ['male', 'female', 'nonbinary']
      skill_levels = ['beginner', 'intermediate', 'advanced']
      times_of_day = ['mornings', 'afternoons', 'evenings']
      workout_types = ['cardio', 'strength_training', 'hiit', 'crossfit', 'yoga', 'pilates', 'dance', 'martial_arts', 'spinning', 'bodybuilding', 'mixed_modal']
      gym_names = ['east_bank_club', 'esporta_fitness', 'equinox', 'la_fitness', 'planet_fitness', 'fitness_formula_club', 'midtown_athletic_club', 'orange_theory_fitness']

      names.each do |name|
        dob = Faker::Date.between(from: '1997-01-01', to: '2005-12-31') # Random DOB between 1960 and 2005
        u = User.create(
          email: "#{name}@example.com", 
          password: "password",
          first_name: name,
          last_name: last_names.sample,
          username: name,
          bio: Faker::Lorem.paragraph(        
            sentence_count: 2,        
            supplemental: true,        
            random_sentences_to_add: 4      
            ),
          dob: dob,
          gender: genders.sample,
          gym_frequency_category: gym_frequencies.sample,
          ideal_match_gender: ideal_match_genders.sample(rand(1..ideal_match_genders.size)),
          skill_level: skill_levels.sample,
          time_of_day: times_of_day.sample,
          type_of_workouts: workout_types.sample,
          user_gym: gym_names.sample
          
          )
        puts "Creating user with username: #{u.username} and email: #{name}@example.com"
        puts "added #{u.email}"
        puts "added #{u.user_gym}"
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
            body: Faker::TvShows::BigBangTheory.quote
          )
        end
      end
      puts "done"
      p "There are now #{User.count} users."
      p "There are now #{Match.count} matches."
      p "There are now #{Message.count} messages."
    end
  end
end
