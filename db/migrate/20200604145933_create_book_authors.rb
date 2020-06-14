class CreateBookAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :book_authors do |t|
      t.string :author, null:false
      t.integer :book_id, null:false

      t.timestamps
    end
  end
end
