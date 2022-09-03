class Spot < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :spot_tag_relations, dependent: :destroy
  has_many :tags, through: :spot_tag_relations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  def save_tag(tag_list)
    if !tags.nil?
      spot_tag_relations_records = SpotTagRelation.where(spot_id: id)
      spot_tag_relations_records.destroy_all
    end

    # tag_list.select do |tag|
    #   tag.present?
    # end
    tag_list.select(&:present?).each do |tag|
      inspected_tag = Tag.find(tag)
      tags << inspected_tag
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def avg_star
    unless self.posts.empty?
      posts.average(:star).round(1).to_f
    else
      0.0
    end
  end

end
