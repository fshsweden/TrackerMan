class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :player_id
      t.string :lat
      t.string :lng

      t.timestamps null: false
    end
  end
end
