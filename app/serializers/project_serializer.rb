class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :materials, :length, :image, :image_content_type, :image_file_size, :image_updated_at

  belongs_to :user
  has_many :themes
end
