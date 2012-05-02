class CreateMarkas < ActiveRecord::Migration
  def change
    create_table :markas do |t|
      t.string :name
      t.timestamps
    end
  end
end
