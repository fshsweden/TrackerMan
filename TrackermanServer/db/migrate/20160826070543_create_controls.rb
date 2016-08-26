class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|
      t.string :name
      t.string :description
      t.float :lat
      t.float :lng
      t.string :h
      t.integer :track_id

      t.timestamps null: false
    end
  end
end
