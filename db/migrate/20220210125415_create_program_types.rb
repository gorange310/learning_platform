class CreateProgramTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :program_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
