class ReviewAuthor < ApplicationRecord
  belongs_to :review
  def self.ransackable_attributes(auth_object = nil)
    %w[author]
  end
end
