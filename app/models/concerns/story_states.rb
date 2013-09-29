module StoryStates
  extend ActiveSupport::Concern

  included do
    state_machine :state, initial: :new do
      state :new
      state :started
      state :finished
      state :accepted
      state :rejected

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

  module ClassMethods
    def state_names
      state_machines[:state].states.map(&:name)
    end
  end

end