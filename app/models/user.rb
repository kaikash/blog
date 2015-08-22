class User < ActiveRecord::Base
  include BCrypt

  has_many :articles

  validates :username, presence: true, length: {in: 6..255}
  validates :password, presence: true, length: {in: 6..255}
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, presence: true, length: {in: 3..255}
  validates :surname, presence: true, length: {in: 3..255}

  enum role: [:guest, :user, :admin]

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def fullname
    "#{name} #{surname}"
  end
end
