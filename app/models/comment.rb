class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :story

  has_ancestry

  validates :body, presence: true
  validates :story, presence: true
end
