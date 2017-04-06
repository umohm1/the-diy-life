class DropUserProjectsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :user_projects 
  end
end
