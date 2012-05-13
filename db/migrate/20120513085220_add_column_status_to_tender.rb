class AddColumnStatusToTender < ActiveRecord::Migration
  def change
  	add_column :tenders, :status, :boolean, :default => false
  end
end
