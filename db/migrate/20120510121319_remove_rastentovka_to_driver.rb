class RemoveRastentovkaToDriver < ActiveRecord::Migration
  def up
  	remove_column :drivers, :rastentovka_ids
  	remove_column :drivers, :rastentovka
  	add_column :drivers, :rastentovka_ids, :string
  end

  def down
  end
end
