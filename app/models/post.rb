class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  has_many :favorits, dependent: :destroy
  
end
