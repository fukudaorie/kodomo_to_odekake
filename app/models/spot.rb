class Spot < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :spot_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy
  has_one_attached :image
end
