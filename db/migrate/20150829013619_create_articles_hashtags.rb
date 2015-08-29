class CreateArticlesHashtags < ActiveRecord::Migration
  def change
    create_table :articles_hashtags do |t|
      t.belongs_to :hashtag, index: true
      t.belongs_to :article, index: true
    end
  end
end
