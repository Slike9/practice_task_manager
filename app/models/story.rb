class Story < ActiveRecord::Base
  include StoryStates

  belongs_to :owner, class_name: 'User'
  belongs_to :author, class_name: 'User'
end
