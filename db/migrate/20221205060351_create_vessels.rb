class CreateVessels < ActiveRecord::Migration[6.1]
  def change
    create_table :vessels do |t|
      t.string :name, null: false
      t.string :owner_id, null: false
      t.string :naccs, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :vessels, :naccs, unique: true
  end
end
