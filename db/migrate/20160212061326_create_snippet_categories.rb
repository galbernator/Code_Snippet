class CreateSnippetCategories < ActiveRecord::Migration
  def change
    create_table :snippet_categories do |t|
      t.references :snippet, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
