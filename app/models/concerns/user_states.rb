module UserStates
  extend ActiveSupport::Concern

  included do
    state_machine :state, initial: :new do
      state :new
      state :registered

      event :register do
        transition :new => :registered
      end
    end
  end

end