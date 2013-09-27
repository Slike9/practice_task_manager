FactoryGirl.define do
  factory :story, aliases: [:new_story] do
    title 'Make the user happy'
    description 'Implement super feature'
    author
    owner
  end
end