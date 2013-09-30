# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyText"
    author
    story
  end

  factory :child_comment do
    body "It is a child comment"
    author
    association :parent, factory: :comment
  end

  factory :comment_with_children, parent: :comment do
    ignore do
      child_count 5
    end
    after(:create) do |comment, evaluator|
      FactoryGirl.create_list(:child_comment, evaluator.child_count, parent: comment)
    end
  end
end
