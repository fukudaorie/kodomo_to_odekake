class Spot < ApplicationRecord
  belongs_to :genre
  has_many :posts, dependent: :destroy

  has_one_attached :image
end
