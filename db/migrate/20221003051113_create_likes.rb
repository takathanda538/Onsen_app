class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
<<<<<<< HEAD
      t.bigint :customer, null: false
      t.bigint :post, null: false
=======
      t.references :customer,type: :bigint, null: false, foreign_key: true
      t.references :post,type: :bigint, null: false, foreign_key: true
>>>>>>> 7fb425b88771d63f751e650a2590b63b3c49d8f8

      t.timestamps
    end
  end
end
