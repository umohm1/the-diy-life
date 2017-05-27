class Project < ApplicationRecord

attr_accessor :image

  belongs_to :user
  has_many :project_themes
  has_many :themes, through: :project_themes

  validates_presence_of :name, :materials, :length

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :other_users_projects, ->(id){where.not(user_id: id)}

def all_themes=(all_themes)
  self.themes = all_themes.split(",").map do |t|
    Theme.where(name: t).first_or_create!
  end
end

def all_themes
  themes.map(&:name).join(" ,")
 end
end
