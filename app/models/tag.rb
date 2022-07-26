class Tag < ApplicationRecord
  has_many :spot_tag_relations, dependent: :destroy
  has_many :spots, through: :spot_tag_relations, dependent: :destroy
end
