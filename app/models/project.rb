class Project < ApplicationRecord

  has_many :users, through: :user_projects
end
