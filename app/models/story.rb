class Story < ActiveRecord::Base
  include StoryStates

  belongs_to :owner, class_name: 'User'
  belongs_to :author, class_name: 'User'
  has_many :comments

  validates :title, presence: true

  accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: :all_blank

  paginates_per 10
end
