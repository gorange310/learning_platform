class AddNameNullFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :currencies, :name, :string, :null => false
    change_column :program_categories, :name, :string, :null => false
    change_column :program_types, :name, :string, :null => false
  end
end
