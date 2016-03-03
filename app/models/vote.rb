class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :snippet

  validates :snippet_id, uniqueness: {scope: :user_id}
  
end
