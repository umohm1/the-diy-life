class AddProjectIdToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :project_id, :integer
  end
end
