class CreateUserPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_programs do |t|
      t.integer :user_id, :index => true
      t.integer :program_id, :index => true
      t.date :expired_date, :index => true
      t.timestamps
    end

    add_index :user_programs, [:user_id, :program_id], :unique => true
  end
end
