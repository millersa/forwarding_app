class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :organization
      t.string :contlico
      t.string :phone
      t.text :gruz

      t.timestamps
    end
  end
end
