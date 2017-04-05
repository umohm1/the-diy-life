class Project < ApplicationRecord

attr_accessor :image

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :themes

  validates_presence_of :name, :materials, :length

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

def all_themes=(all_themes)
  self.themes = all_themes.split(",").map do |t|
    Theme.where(name: t).first_or_create!
  end
end

def all_themes
  themes.map(&:name).join(" ,")
end



end
