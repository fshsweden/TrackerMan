class AddLoginTimeToPlayer < ActiveRecord::Migration
  def change
	add_column :players, :login_time, :datetime
  end
end
