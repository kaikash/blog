class FixUserProvider < ActiveRecord::Migration
  def change
    rename_column :users, :provier, :provider
  end
end
