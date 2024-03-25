class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :profile_picture, :string
    add_column :users, :gender, :string
    add_column :users, :user_gym, :string
  end
end
