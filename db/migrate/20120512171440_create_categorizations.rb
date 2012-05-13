class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :raztentovka_id
      t.integer :driver_id

      t.timestamps
    end
  end
end
