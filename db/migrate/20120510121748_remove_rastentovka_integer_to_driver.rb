class RemoveRastentovkaIntegerToDriver < ActiveRecord::Migration
  def up
  	remove_column :drivers, :rastentovka_ids
  	remove_column :drivers, :rastentovka_id
  end

  def down
  end
end
