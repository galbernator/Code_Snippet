class CreateNoteCategories < ActiveRecord::Migration
  def change
    create_table :note_categories do |t|
      t.references :note, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
