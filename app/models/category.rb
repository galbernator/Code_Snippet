class Category < ActiveRecord::Base

  has_many :snippet_categories, dependent: :destroy
  has_many :snippets, through: :snippet_categories
  has_many :note_categories, dependent: :destroy
  has_many :notes, through: :note_categories

  validates :title, uniqueness: true, presence: true

end
