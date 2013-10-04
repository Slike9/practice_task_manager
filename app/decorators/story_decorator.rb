class StoryDecorator < Draper::Decorator
  delegate_all

  delegate :name, to: :author, prefix: true, allow_nil: true
  delegate :name, to: :owner, prefix: true, allow_nil: true
end
