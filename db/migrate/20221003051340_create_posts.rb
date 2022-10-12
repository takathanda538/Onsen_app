class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :name
      t.string :title
      t.text :body
      t.integer :ride_area, null: false, default: 0

      t.timestamps
    end
  end
end
