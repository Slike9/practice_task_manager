class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  def to_s
    email
  end
end
