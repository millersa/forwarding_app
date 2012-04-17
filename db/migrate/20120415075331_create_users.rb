class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :otchestvo
      t.string :sex
      t.date :datebirth
      t.string :doljnost
      t.date :datework
      t.integer :seriy
      t.integer :nomer
      t.string :vidan
      t.string :phone

      t.timestamps
    end
  end
end
