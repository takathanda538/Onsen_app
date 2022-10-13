class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.bigint :customer, null: false
      
      t.bigint :post, null: false

      t.timestamps
    end
  end
end
