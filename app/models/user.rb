class User < ActiveRecord::Base
  include UserStates

  has_many :assigned_stories, foreign_key: 'owner_id', class_name: 'Story', dependent: :nullify
  has_many :authored_stories, foreign_key: 'author_id', class_name: 'Story', dependent: :nullify

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  has_secure_password validations: false

  mount_uploader :avatar, AvatarUploader

  def name
    email
  end

  def to_s
    name
  end
end
