class AddColumnIsUpToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :is_up, :boolean
  end
end
