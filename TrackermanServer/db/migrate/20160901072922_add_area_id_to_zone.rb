class AddAreaIdToZone < ActiveRecord::Migration
  def change
    change_table :zones do |t|
      t.integer :area_id
    end
  end
end
