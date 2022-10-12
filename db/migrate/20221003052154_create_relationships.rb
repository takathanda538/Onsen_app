class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :following, foreign_key: { to_table: :customers }
      t.references :follower, foreign_key: { to_table: :customers }

      t.timestamps
    end
  end
end
