class RemoveProjectIdFromThemesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :themes, :project_id, :integer
  end
end
