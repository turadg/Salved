class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :label
      t.string :filesPath

      t.timestamps
    end
  end
end
