# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
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

end
