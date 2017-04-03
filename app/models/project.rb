class Project < ApplicationRecord

  attr_accessor :tag_name
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :tags

  validates_presence_of :name, :materials, :length

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

def tag_name=(taggings)
  self.tags = taggings.split(",").map do |t|
    Tag.where(name: t).first_or_create!
  end
end

def tag_name
end

end
