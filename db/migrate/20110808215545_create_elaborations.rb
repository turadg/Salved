class CreateElaborations < ActiveRecord::Migration
  def change
    create_table :elaborations do |t|
      t.string :status
      t.integer :difficulty
      t.text :note_to_self
      t.text :note_to_instructor

      t.timestamps
    end
  end
end
