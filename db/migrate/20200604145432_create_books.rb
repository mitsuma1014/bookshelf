class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :genre
      t.date :finished_at
      t.text :description
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
