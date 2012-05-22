class AddToUsersf < ActiveRecord::Migration
  def up
  	add_column :users, :role, :string
  	add_column :users, :roles_mask, :integer
  end

  def down
  end
end
