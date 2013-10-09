FactoryGirl.define do
  factory :user, aliases:[:author, :owner] do
    sequence(:email) { |n| "bill#{n}@ms.ru"}
    password '1'
  end

  factory :user_with_password_confirmation, parent: :user do
    password_confirmation '1'
  end
end