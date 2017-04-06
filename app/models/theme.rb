class Theme < ApplicationRecord
  has_many :theme_projects
  has_many :projects, through: :theme_projects
end
