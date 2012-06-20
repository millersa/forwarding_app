class AddWaytoTenders < ActiveRecord::Migration
  def up
  	add_column :tenders, :way_id, :string
  end

  def down
  end
end
