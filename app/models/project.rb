class Project < ApplicationRecord

  attr_accessor :image

  belongs_to :user
  has_many :project_themes
  has_many :themes, through: :project_themes

  validates_presence_of :name, :materials, :length

  has_attached_file :image, styles: {medium: "505x505>", thumb: "100x100>" }, default_url: "http://lorempixel.com/output/abstract-q-c-400-400-8.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :other_users_projects, -> (id) {where.not(user_id: id)}

  def theme_attributes=(theme_attributes)
    theme_attributes.split(",").map do |theme_name|
      self.themes << Theme.where(name: theme_name).first_or_create!
    end
  end

  def theme_attributes
    themes.map(&:name).join(" ,") #themes.map {|theme| theme.name}.join(",")
  end
end
