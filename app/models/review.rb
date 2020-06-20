class Review < ApplicationRecord
  has_many :review_authors, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :review_authors, reject_if: :reject_review_authors, allow_destroy: true

  def reject_review_authors(attributes)
    exists = attributes[:id].present?
    empty = attributes[:author].blank?
    attributes.merge!(_destroy:1) if exists && empty
    !exists && empty
  end

  validates :title, :content, presence:true
  validates :content, length: {maximum: 100}

  def self.ransackable_attributes(auth_object = nil)
    %w[title author genre]
  end

  AUTHORS_FORM = 3 

  def owned_by?(user)
    user_id == user.id
  end
end
