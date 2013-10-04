class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

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
