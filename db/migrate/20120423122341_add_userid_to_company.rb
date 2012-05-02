class AddUseridToCompany < ActiveRecord::Migration
  change_table :companies do |t|
    t.integer :user_id
  	t.index :user_id
  end
end
