class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :user

	validates :title, presence: true, length: {in: 5..140}
	validates :content, presence: true, length: {in: 10..10000}

  default_scope { order("created_at DESC") }

  def content_short
    return "#{content.slice(0..300)}..." if content.length>300
    content
  end

  def date
    created_at.to_formatted_s :short
  end
end
