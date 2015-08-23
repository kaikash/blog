class User < ActiveRecord::Base
  has_secure_password

  has_many :articles

  validates :username, presence: true, length: {in: 6..255}, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {in: 6..255}
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: {in: 3..255}
  validates :surname, presence: true, length: {in: 3..255}

  enum role: [:guest, :user, :admin]

  def fullname
    "#{name} #{surname}"
  end
end
