class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :lat
      t.string :lng

      t.timestamps null: false
    end
  end
end
