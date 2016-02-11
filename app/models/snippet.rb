class Snippet < ActiveRecord::Base
  belongs_to :category

  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  validates :title, uniqueness: true

  after_initialize :set_defaults

  def vote_for(user)
    votes.find_by_user_id(user)
  end

  def vote_result
    count = 0
    votes.each {|v| v.is_up? ? count += 1 : count -= 1}
    count
  end

  def author(current_user)
    user == current_user
  end

  private

  def set_defaults
    self.is_private ||= false
  end


end
