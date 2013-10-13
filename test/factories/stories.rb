FactoryGirl.define do
  factory :story, aliases: [:new_story] do
    sequence(:title) {|n| "Story ##{n}"}
    sequence(:description) {|n| "Implement feature ##{n}" }
    author
    owner
  end

  factory :story_with_comments, parent: :story do
    ignore do
      comment_count 5
    end

    after(:create) do |story, evaluator|
      FactoryGirl.create_list('story/comment_with_children', evaluator.comment_count, story: story)
    end
  end
end