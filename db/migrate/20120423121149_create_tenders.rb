class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.string :price
      t.integer :driver_id
      t.integer :company_id
      t.string :form_oplata
      t.string :route
      t.string :adress_pogruzka
      t.date :date_pogruzki
      t.time :vremy_pogruzki
      t.string :gruzotpravitel
      t.string :adress_razgruzki
      t.date :data_razgruzki
      t.time :vremy_razgruzlki
      t.string :gruzopoluhatel

      t.timestamps
    end
  end
end
