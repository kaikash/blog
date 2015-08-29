class FixUser < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest
    add_column :users, :provier, :string
    add_column :users, :uid, :string
    add_column :users, :img, :string
  end
end
