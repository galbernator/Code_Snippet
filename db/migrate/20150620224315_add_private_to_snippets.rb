class AddPrivateToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :is_private, :boolean
  end
end
