class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :api_key

      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :email, unique: true
    add_index :users, :api_key, unique: true
  end
end
