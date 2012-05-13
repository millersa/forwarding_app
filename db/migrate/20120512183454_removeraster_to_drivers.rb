class RemoverasterToDrivers < ActiveRecord::Migration
  def up
  	remove_column :drivers, :rastentovka_ids
  end

  def down
  end
end
