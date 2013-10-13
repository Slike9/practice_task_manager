# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory 'story/comment' do
    sequence(:body) {|n| "Comment #{n} body" }
    author
    story
  end

  factory 'story/comment_with_children', parent: 'story/comment' do
    ignore do
      child_count 5
    end
    after(:create) do |comment, evaluator|
      FactoryGirl.create_list('story/comment', evaluator.child_count, parent: comment, story: comment.story)
    end
  end
end
