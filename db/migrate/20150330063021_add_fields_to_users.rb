class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    rename_column :users, :name, :last_name
  end
end
