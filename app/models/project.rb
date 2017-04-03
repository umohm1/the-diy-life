class Project < ApplicationRecord

  attr_accessor :tag_name
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :tags

  validates_presence_of :name, :materials, :length

def tag_name=(taggings)
  self.tags = taggings.split(",").map do |t|
    Tag.where(name: t).first_or_create!
  end
end

def tag_name
end

end
