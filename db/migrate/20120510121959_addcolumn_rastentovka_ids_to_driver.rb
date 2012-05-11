class AddcolumnRastentovkaIdsToDriver < ActiveRecord::Migration
  def up
  	add_column :drivers, :rastentovka_ids, :string
  end

  def down
  end
end
