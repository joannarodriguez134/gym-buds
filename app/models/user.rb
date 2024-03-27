# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  dob                    :date
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  gender                 :string
#  gym_frequency_category :string
#  ideal_match_gender     :string
#  last_name              :string
#  profile_picture        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  skill_level            :string
#  time_of_day            :string
#  type_of_workouts       :string
#  user_gym               :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   #  when the user is the one who initiates the match request
   has_many :requested_matches, class_name: 'Match', foreign_key: 'requester_id'

   # when the user is the one who approves the match request
   has_many :approved_matches, class_name: 'Match', foreign_key: 'approver_id'

   has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'

  def rejected_matches
    Match.where("(requester_id = :user_id OR approver_id = :user_id) AND status = :status", user_id: id, status: 'rejected')
  end


  # Enums
  enum gender: { male: 'male', female: 'female', nonbinary: 'nonbinary' }

  enum gym_frequency_category: {
       daily: 'daily',
       twice_a_week: 'twice_a_week',
       multiple_times_a_week: 'multiple_times_a_week',
       weekly: 'weekly',
       every_two_weeks: 'every_two_weeks',
       occasionally: 'occasionally',
       rarely: 'rarely'
     }

     enum ideal_match_gender: { 
      match_gender_male: 'male', 
      match_gender_female: 'female', 
      match_gender_nonbinary: 'nonbinary' 
    }

  enum skill_level: { beginner: 'beginner', intermediate: 'intermediate', advanced: 'advanced' }

  enum time_of_day: { mornings: 'mornings', afternoons: 'afternoons', evenings: 'evenings' }

  enum type_of_workouts: {
       cardio: 'cardio',
       strength_training: 'strength_training',
       hiit: 'hiit',
       crossfit: 'crossfit',
       yoga: 'yoga',
       pilates: 'pilates',
       dance: 'dance',
       martial_arts: 'martial_arts',
       spinning: 'spinning',
       bodybuilding: 'bodybuilding',
       mixed_modal: 'mixed_modal'
}


  enum user_gym: {

      east_bank_club: 'east_bank_club',
      esporta_Fitness: 'esporta_fitness', 
      equinox: 'equinox',
      la_fitness: 'la_fitness',
      planet_fitness: 'planet_fitness',
      fitness_formula_club: 'fitness_formula_club',
      midtown_athletic_club: 'midtown_athletic_club',
      orange_theory_fitness: 'orange_theory_fitness' }

      # these method are to have a more readable string in the view rather than 
      # <%= @user.user_gym %>

      def gym_name
        {
          east_bank_club: 'East Bank Club',
          esporta_fitness: 'Esporta Fitness',
          equinox: 'Equinox',
          la_fitness: 'LA Fitness',
          planet_fitness: 'Planet Fitness',
          fitness_formula_club: 'Fitness Formula Club',
          midtown_athletic_club: 'Midtown Athletic Club',
          orange_theory_fitness: 'Orange Theory Fitness'
        }[self.user_gym.to_sym] || self.user_gym
      end

      def user_gym_frequency
        {
        daily: 'daily',
       twice_a_week: 'twice a week',
       multiple_times_a_week: 'multiple times a week',
       weekly: 'weekly',
       every_two_weeks: 'every two weeks',
       occasionally: 'occasionally',
       rarely: 'rarely'
      }[self.gym_frequency_category] || self.gym_frequency_category
      end

    def workouts 
      {
        cardio: 'cardio',
        strength_training: 'strength training',
        hiit: 'hiit',
        crossfit: 'crossfit',
        yoga: 'yoga',
        pilates: 'pilates',
        dance: 'dance',
        martial_arts: 'martial arts',
        spinning: 'spinning',
        bodybuilding: 'bodybuilding',
        mixed_modal: 'mixed modal'
      }[self.type_of_workouts] || self.type_of_workouts
    end

    # Method to calculate age from dob
  def age
    return unless dob

    now = Time.zone.now.to_date
    age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    age
  end

end
