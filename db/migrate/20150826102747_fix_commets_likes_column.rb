class FixCommetsLikesColumn < ActiveRecord::Migration
  def change
    rename_column :comments, :like, :likes
  end
end
