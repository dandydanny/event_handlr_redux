class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.date :birthdate, :null => false
      #bcrypt hashed password var
      #t.string :password, :null => false
      t.string :password_digest, :null => false
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end
