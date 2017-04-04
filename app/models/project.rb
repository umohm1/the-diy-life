class Project < ApplicationRecord

  attr_accessor :tag_name

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :themes

  validates_presence_of :name, :materials, :length

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

def theme_attributes=(theme_attributes)
  self.themes = themes.split(",").map do |t|
    Theme.where(name: t).first_or_create!
  end
end

def theme_attributes
end

end
