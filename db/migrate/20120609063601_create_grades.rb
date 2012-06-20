class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.boolean :mark
      t.text :more
      t.references :gradable, :polymorphic => true

      t.timestamps
    end
  end
end
