class CreateSearch < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
