class Snippet < ActiveRecord::Base
  belongs_to :category

  belongs_to :user

  validates :title, uniqueness: true
end
