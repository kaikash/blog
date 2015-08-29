class Search < ActiveRecord::Base
  belongs_to :user

  validates :query, length: { in: 2..256 } 
end
