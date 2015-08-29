class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :articles

  validates :hashtag, length: { in: 1..255 }
end
