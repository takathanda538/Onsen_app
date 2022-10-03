class CreateOnsenTags < ActiveRecord::Migration[6.1]
  def change
    create_table :onsen_tags do |t|
      t.references :onsen, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
