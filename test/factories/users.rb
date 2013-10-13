FactoryGirl.define do
  factory :user, aliases:[:author, :owner] do
    email
    password '1'
  end

  factory :user_with_password_confirmation, parent: :user do
    password_confirmation '1'
  end
end