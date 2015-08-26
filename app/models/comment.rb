class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :article

  validates :text, presence: true, length: {in: 6..255}

  def date
    created_at.to_formatted_s :short
  end
end
