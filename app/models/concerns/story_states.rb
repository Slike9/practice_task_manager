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

  def try_fire_state_event(event)
    can_fire_state_event?(event) ? fire_state_event(event) : false
  end

  def can_fire_state_event?(event)
    state_events.any?{|x| x.to_s == event.to_s}
  end
end