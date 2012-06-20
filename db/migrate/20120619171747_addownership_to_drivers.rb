class AddownershipToDrivers < ActiveRecord::Migration
  def up
  	add_column :drivers, :ownership, :boolean, :default => false
  end

  def down
  end
end
