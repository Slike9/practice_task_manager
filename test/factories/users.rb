FactoryGirl.define do
  factory :user, aliases:[:author, :owner] do
    sequence(:email) { |n| "bill#{n}@ms.ru"}
    password '1'
    password_confirmation '1'
  end
end