class Note < ActiveRecord::Base

  belongs_to :user

  has_many :note_categories, dependent: :destroy
  has_many :categories, through: :note_categories

  validates :title, :body, presence: true

  before_save :prettify_code_block

  private

  def prettify_code_block
    self.body = self.body.gsub(/```/, "~~~")
  end

end
