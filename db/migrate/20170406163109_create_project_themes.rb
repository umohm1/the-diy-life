class CreateProjectThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :project_themes do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :theme, foreign_key: true

      t.timestamps
    end
  end
end
