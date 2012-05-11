class AddRastentovkaIdToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :rastentovka_id, :integer

  end
end
