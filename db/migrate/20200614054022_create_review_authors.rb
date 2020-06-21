class CreateReviewAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :review_authors do |t|
      t.string :author, null: false
      t.integer :review_id, null:false

      t.timestamps
    end
  end
end
