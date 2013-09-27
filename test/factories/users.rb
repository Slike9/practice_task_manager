FactoryGirl.define do
  factory :user, aliases:[:author, :owner] do
    sequence :email do |n|
      "bill#{n}@ms.ru"
    end
    password '1'
    password_confirmation '1'
  end
end