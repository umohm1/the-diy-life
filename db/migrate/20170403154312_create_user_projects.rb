class CreateUserProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_projects do |t|
      t.references :user
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
