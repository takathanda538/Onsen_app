class CreateOnsenComments < ActiveRecord::Migration[6.1]
  def change
    create_table :onsen_comments do |t|

      t.timestamps
    end
  end
end
