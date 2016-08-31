class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.integer :lat
      t.integer :lng
      t.integer :value

      t.timestamps null: false
    end
  end
end
