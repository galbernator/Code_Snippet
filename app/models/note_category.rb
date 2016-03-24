class NoteCategory < ActiveRecord::Base
  belongs_to :note
  belongs_to :category
end
