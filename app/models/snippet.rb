class Snippet < ActiveRecord::Base
  belongs_to :category

  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user
  has_many :snippet_categories, dependent: :destroy
  has_many :categories, through: :snippet_categories

  validates :title, uniqueness: true
  validates :block, presence: true

  after_initialize :set_defaults
  before_save :format_block

  scope :created_by, lambda { |user| where(user_id: user) }
  scope :not_private, -> { where(is_private: false) }
  scope :search_for, lambda { |query| where('snippets.title ILIKE ? OR snippets.block ILIKE ? OR snippets.description ILIKE ?', query, query, query).uniq }
  scope :with_category, lambda { |category| joins(:snippet_categories).where('snippet_categories.category_id = ?', category) }


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

  def format_block
    self.block = self.block.gsub(/[\r\t]/, "\r" => "", "\t" => "\s\s") if self.block.present?
  end


end
