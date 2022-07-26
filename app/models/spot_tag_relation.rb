class SpotTagRelation < ApplicationRecord
  belongs_to :spot
  belongs_to :tag
end
