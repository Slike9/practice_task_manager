class User < ActiveRecord::Base
  include UserStates

  has_many :assigned_stories, foreign_key: 'owner_id', class_name: 'Story', dependent: :nullify
  has_many :authored_stories, foreign_key: 'author_id', class_name: 'Story', dependent: :nullify

  validates :email, presence: true, uniqueness: true

  has_secure_password

  mount_uploader :avatar, AvatarUploader

  def just_registered?
    persisted? && created_at == updated_at
  end

  def name
    email
  end

  def to_s
    name
  end
end
