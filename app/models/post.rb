class Post < ApplicationRecord
  validates :star, presence: true
  validates :comment, presence: true

  belongs_to :user
  belongs_to :spot

end
