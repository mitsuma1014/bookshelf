class BookAuthor < ApplicationRecord
  belongs_to :book
  def self.ransackable_attributes(auth_object = nil)
    %w[author]
  end

end
