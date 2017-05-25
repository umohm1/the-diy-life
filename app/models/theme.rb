class Theme < ApplicationRecord
  has_many :project_themes
  has_many :projects, through: :project_themes
end
