class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
  has_and_belongs_to_many :hashtags
	belongs_to :user

  # before_save :gsub_hashtags

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

  # def self.gsub_hashtags
  # end

  def find_hashtags
    _hashtags = []
    "#{title} #{content}".split.each do |word|
      if word[0] == "#"
        _hashtag = Hashtag.find_or_create_by hashtag: word[1..-1]
        _can_add = true
        _hashtags.each do |h|
          if _hashtag.id == h.id
            _can_add = false
            break
          end
        end
        _hashtags<<_hashtag if _can_add
      end
    end
    # raise _hashtags.inspect
    _hashtags.map {|h| hashtags<<h}
  end
end
