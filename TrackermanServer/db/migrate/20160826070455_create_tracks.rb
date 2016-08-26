class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :track_type
      t.string :difficulty
      t.string :length

      t.timestamps null: false
    end
  end
end
