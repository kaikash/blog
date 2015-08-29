class User < ActiveRecord::Base
  has_many :articles
  has_many :searches

  validates :email, allow_nil: true, allow_blank: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: { case_sensitive: false }
  validates :name, presence: false, length: {in: 3..255}
  validates :surname, presence: true, length: {in: 3..255}

  enum role: [:guest, :user, :admin]

  def fullname
    "#{name} #{surname}"
  end

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["first_name"]
      user.surname = auth["info"]["last_name"]
      user.img = auth["info"]["image"]
      user.email = auth["info"]["email"]
      user.role = 1
    end
  end
end
