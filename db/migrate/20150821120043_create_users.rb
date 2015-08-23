class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :password_digest
    	t.string :username, unique: true
    	t.string :email, unique: true
    	t.string :name
    	t.string :surname
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
