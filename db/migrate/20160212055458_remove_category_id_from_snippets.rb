class RemoveCategoryIdFromSnippets < ActiveRecord::Migration
  def change
    remove_column :snippets, :category_id, :integer
  end
end
