class Snippet < ActiveRecord::Base
  belongs_to :category

  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user
  has_many :snippet_categories, dependent: :destroy
  has_many :categories, through: :snippet_categories

  validates :title, uniqueness: true

  after_initialize :set_defaults

  scope :created_by, lambda { |user| where(user_id: user) }
  scope :not_private, -> { where(is_private: false) }
  scope :search_for, lambda { |query| where("snippets.title ILIKE ? OR snippets.block ILIKE ? OR snippets.description ILIKE ?", query, query, query).uniq }


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
