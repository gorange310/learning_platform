class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :program_category_id, :index => true
      t.integer :currency_id, :index => true
      t.decimal :price
      t.string :program_type_id, :index => true
      t.string :status
      t.string :url
      t.text :description
      t.integer :validity_period, :null => false
      t.timestamps
    end
  end
end
