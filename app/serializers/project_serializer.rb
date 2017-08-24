class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :materials, :image_content_type, :image_file_size, :image_updated_at
  
  belongs_to :user
  has_many :project_themes
  has_many :themes, through: :project_themes
end
