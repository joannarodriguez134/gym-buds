class AddMoreDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :ideal_match_gender, :string
    add_column :users, :skill_level, :string
    add_column :users, :type_of_workouts, :string
    add_column :users, :time_of_day, :string
    add_column :users, :gym_frequency_category, :string
  end
end
