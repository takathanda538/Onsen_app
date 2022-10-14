class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.bigint :customer_id, null: false
      
      t.bigint :post_id, null: false

      t.timestamps
    end
  end
end
