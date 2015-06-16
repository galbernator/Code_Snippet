class Category < ActiveRecord::Base
  has_many :snippets, dependent: :nullify

  validates :title, uniqueness: true
end
