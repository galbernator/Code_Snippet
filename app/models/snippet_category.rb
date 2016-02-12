class SnippetCategory < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :category
end
