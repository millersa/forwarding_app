class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :fname
      t.string :lname
      t.string :oname
      t.string :phone
      t.string :contacts
      t.string :marka
      t.integer :ves
      t.integer :objem
      t.string :gosnomerp
      t.string :gosnomer
      t.integer :seriy
      t.integer :nomerp
      t.string :kemvidan
      t.string :kogdavidan
      t.string :tipkuzova
      t.string :rastentovka

      t.timestamps
    end
  end
end
