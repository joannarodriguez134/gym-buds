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
#  ideal_match_gender     :string           default([]), is an Array
#  last_name              :string
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
  include FileSizeValidator
  include UserEnumsAndScopes
  include UserRelationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :username, presence: true

  
  def gym_name
    {
      east_bank_club: "East Bank Club",
      esporta_fitness: "Esporta Fitness",
      equinox: "Equinox",
      la_fitness: "LA Fitness",
      planet_fitness: "Planet Fitness",
      fitness_formula_club: "Fitness Formula Club",
      midtown_athletic_club: "Midtown Athletic Club",
      orange_theory_fitness: "Orange Theory Fitness",
    }[self.user_gym.to_sym] || self.user_gym
  end

  def self.gym_name_options
    user_gyms.keys.map do |key|
      [User.new(user_gym: key).gym_name, key]
    end
  end

  def user_gym_frequency
    {
      daily: "daily",
      twice_a_week: "twice a week",
      multiple_times_a_week: "multiple times a week",
      weekly: "weekly",
      every_two_weeks: "every two weeks",
      occasionally: "occasionally",
      rarely: "rarely",
    }[self.gym_frequency_category] || self.gym_frequency_category
  end

  def self.user_gym_frequency_options
    gym_frequency_categories.keys.map do |key|
      [User.new(gym_frequency_category: key).user_gym_frequency, key]
    end
  end

  def workouts
    {
      cardio: "cardio",
      strength_training: "strength training",
      hiit: "hiit",
      crossfit: "crossfit",
      yoga: "yoga",
      pilates: "pilates",
      dance: "dance",
      martial_arts: "martial arts",
      spinning: "spinning",
      bodybuilding: "bodybuilding",
      mixed_modal: "mixed modal",
    }[self.type_of_workouts] || self.type_of_workouts
  end

  def self.workouts_options
    gym_frequency_categories.keys.map do |key|
      [User.new(gym_frequency_category: key).user_gym_frequency, key]
    end
  end

  def age
    return unless dob

    now = Time.zone.now.to_date
    age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    age
  end

  def full_name
    [first_name, last_name].join(" ")
  end
end
