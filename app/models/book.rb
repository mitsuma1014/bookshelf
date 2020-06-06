class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :book_authors

  validates :title, presence:true

end
