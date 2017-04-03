class Project < ApplicationRecord

  has_many :users, through: :user_projects
  has_many :tags
end
