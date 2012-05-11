class CreateRaztentovkas < ActiveRecord::Migration
  def change
    create_table :raztentovkas do |t|
      t.string :name

      t.timestamps
    end
  end
end
