class CreateBorders < ActiveRecord::Migration
  def change
    create_table :borders do |t|

      t.integer :zone_id
      t.float :lat_start
      t.float :lng_start
      t.float :lat_end
      t.float :lng_end

      t.timestamps null: false
    end
  end
end
