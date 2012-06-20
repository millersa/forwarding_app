class AddToTenderslico < ActiveRecord::Migration
  def up
  	add_column :tenders, :licoP_id, :integer
  	add_column :tenders, :licoR_id, :integer
  end

  def down
  end
end
