class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
