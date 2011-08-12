class RemoveImageTypeFromProblems < ActiveRecord::Migration
  def up
    # old way to make the path: imagePath = dir + "/step-" + i + extension;
    # new way, templating whatever URL with {{stepIndex}}
    execute <<-SQL
      UPDATE "problems" SET "filesPath" = "filesPath" || '/step-{{stepIndex}}' || "imageType"
    SQL
    remove_column :problems, :imageType
  end

  def down
    add_column :problems, :imageType, :string
  end
end
