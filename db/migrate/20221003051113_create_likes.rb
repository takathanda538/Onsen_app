class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :customer,type: :bigint, null: false, foreign_key: true
      t.references :post,type: :bigint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
