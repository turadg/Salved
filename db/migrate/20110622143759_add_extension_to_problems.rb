class AddExtensionToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :imageType, :string
  end
end
