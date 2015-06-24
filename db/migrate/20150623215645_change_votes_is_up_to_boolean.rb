class ChangeVotesIsUpToBoolean < ActiveRecord::Migration
  def change
    remove_column :votes, :is_up, :string
    add_column :votes, :is_up, :boolean
  end
end
