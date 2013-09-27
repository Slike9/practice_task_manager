module StoryStates
  extend ActiveSupport::Concern

  included do
    state_machine :state, initial: :new do
      event :start do
        transition :new => :started
      end

      event :finish do
        transition :started => :finished
      end

      event :accept do
        transition :finished => :accepted
      end

      event :reject do
        transition :finished => :rejected
      end

      event :reopen do
        transition :rejected => :started
      end

    end
  end
end