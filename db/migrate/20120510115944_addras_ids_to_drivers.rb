class AddrasIdsToDrivers < ActiveRecord::Migration
  def up
  	add_column :drivers, :rastentovka_ids, :integer
  end

  def down
  end
end
