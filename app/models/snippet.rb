class Snippet < ActiveRecord::Base
  belongs_to :category

  validates :title, uniqueness: true
end
