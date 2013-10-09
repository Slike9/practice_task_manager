class UserEditType < User
  include BaseType

  has_secure_password validations: true
end