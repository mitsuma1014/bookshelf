class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :book_authors, reject_if: :reject_book_authors, allow_destroy: true

  def reject_book_authors(attributes)
    exists = attributes[:id].present?
    empty = attributes[:author].blank?
    attributes.merge!(_destroy:1) if exists && empty
    !exists && empty
  end

  validates :title, presence:true

  def self.ransackable_attributes(auth_object = nil)
    %w[title genre finished_at]
  end
end

