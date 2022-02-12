class ChangeOrderUserProgramColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :user_program_id, :integer, :null => false
    add_index :orders, :user_program_id
    remove_column :orders, :user_id
    remove_column :orders, :program_id
  end
end
