class User < ActiveRecord::Base
  has_secure_password

  has_many :votes, dependent: :destroy
  has_many :voted_snippets, through: :votes, source: :snippet
  has_many :snippets
  has_many :notes

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
                format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def admin?
    role == 'admin'
  end

end
