class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :omniauth_providers => [:facebook]

  validates :email, presence: true, uniqueness: true


  #has_many :user_projects
  has_many :projects



  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
 end

 def self.most_projects
   #returns the user w/ the most projects
  #  User.select('users.*, COUNT(project.id) FROM ')
  # joins(:projects)
  # .select("users.*, count(projects.id) as scount")
  # .group("users.id")
  # .order("scount DESC")
  # joins("JOIN projects ON users.id = projects.user_id ")
   Project.all.group_by(&:user_id).count

 end
end
