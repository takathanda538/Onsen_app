class AddIsDeletedToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_deleted, :boolean, default: false
    add_column :customers, :name, :string, null: false
    add_column :customers, :introduce, :string
  end
end
