class Story < ActiveRecord::Base
  include StoryStates

  belongs_to :owner, class_name: 'User'
  belongs_to :author, class_name: 'User'
  has_many :comments, ->{order 'created_at desc'}

  validates :title, presence: true

  paginates_per 10
end
