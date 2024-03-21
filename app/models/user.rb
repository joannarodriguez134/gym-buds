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
#  last_name              :string
#  profile_picture        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
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

  # Enums
  enum gender: { male: 'male', female: 'female', nonbinary: 'nonbinary' }

  enum user_gym: {

      east_bank_club: 'East Bank Club',
      esporta_Fitness: 'Esporta Fitness', 
      equinox: 'Equinox',
      la_fitness: 'LA Fitness',
      planet_fitness: 'Planet Fitness',
      fitness_formula_club: 'Fitness Formula Club',
      midtown_athletic_club: 'Midtown Athletic Club',
      orange_theory_fitness: 'Orange Theory Fitness' }
end
