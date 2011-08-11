class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :index
      t.text :justification
      t.string :selfcheck

      t.timestamps
    end
  end
end
