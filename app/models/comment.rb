class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :story

  validates :body, presence: true
  validates :story, presence: true
end
