class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :is_up
      t.references :user, index: true, foreign_key: true
      t.references :snippet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
