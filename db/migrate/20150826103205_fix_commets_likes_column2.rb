class FixCommetsLikesColumn2 < ActiveRecord::Migration
  def change
    rename_column :comments, :likes, :likes_count
  end
end
