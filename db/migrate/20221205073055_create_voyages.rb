class CreateVoyages < ActiveRecord::Migration[6.1]
  def change
    create_table :voyages do |t|
      t.string :from_loc, null: false
      t.string :to_loc, null: false
      t.datetime :departured_at, null: false
      t.datetime :arrived_at, null: false
      t.references :vessel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
