class RemoveMarkaToDrivers < ActiveRecord::Migration
  def up
    remove_column :drivers, :marka
    add_column :drivers, :marka_id, :integer

      end

  def down
    add_column :drivers, :marka, :string
  end
end
