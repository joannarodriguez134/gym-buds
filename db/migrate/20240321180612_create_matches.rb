class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :status
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :approver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
