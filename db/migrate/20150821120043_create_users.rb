class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :password_hash
    	t.string :username
    	t.string :email
    	t.string :name
    	t.string :surname
      t.int :role, default: 0

      t.timestamps
    end
  end
end
