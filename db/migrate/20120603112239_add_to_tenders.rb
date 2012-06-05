class AddToTenders < ActiveRecord::Migration
  def up
  	add_column :tenders, :nomer_tender, :string
  	add_column :tenders, :forma_oplati2, :string
  end

  def down
  end
end
