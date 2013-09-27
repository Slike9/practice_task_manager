require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  test 'initial state is new' do
    story = create(:new_story)
    assert story.new?
  end

  test 'start story' do
    story = create(:new_story)
    story.start
    assert story.started?
  end

  test 'finish started story' do
    story = create(:story, state: :started)
    story.finish
    assert story.finished?
  end

  test 'accept finished story' do
    story = create(:story, state: :finished)
    story.accept
    assert story.accepted?
  end

  test 'reject finished story' do
    story = create(:story, state: :finished)
    story.reject
    assert story.rejected?
  end

  test 'reopen rejected story' do
    story = create(:story, state: :rejected)
    story.reopen
    assert story.started?
  end
end
