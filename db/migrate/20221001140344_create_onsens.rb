class CreateOnsens < ActiveRecord::Migration[6.1]
  def change
    create_table :onsens do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end
