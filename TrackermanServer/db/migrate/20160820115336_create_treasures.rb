class CreateTreasures < ActiveRecord::Migration
  def change
    create_table :treasures do |t|
      t.string :name
      t.integer :lat
      t.integer :lng
      t.integer :value
      t.datetime :start
      t.datetime :stop
      t.integer :num_takers

      t.timestamps null: false
    end
  end
end
