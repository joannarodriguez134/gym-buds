class ChangeIdealMatchGenderToArrayInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :ideal_match_gender, :string, array: true, default: [], using: "string_to_array(ideal_match_gender, ',')"
  end
end
