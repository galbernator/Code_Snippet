class Snippet < ActiveRecord::Base
  belongs_to :category

  belongs_to :user

  validates :title, uniqueness: true

  after_initialize :set_defaults

  private

  def set_defaults
    self.is_private ||= false
  end


end
