class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :text
      t.belongs_to :user, index: true
      t.belongs_to :article, index: true
      t.integer :like, default: 0

      t.timestamps
    end
  end
end
