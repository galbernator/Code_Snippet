class Note < ActiveRecord::Base

  belongs_to :user

  has_many :note_categories, dependent: :destroy
  has_many :categories, through: :note_categories

  validates :title, :body, presence: true

end
