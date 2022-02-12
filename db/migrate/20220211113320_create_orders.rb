class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, :index => true
      t.integer :program_id, :index => true
      t.decimal :amount
      t.integer :currency_id, :index => true
      t.string :status, :default => 'unpaid'
      t.date :date
      t.timestamps
    end
  end
end
