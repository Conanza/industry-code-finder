class CreateNaicsCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :naics_codes do |t|
      t.string :code_number, null: false
      t.timestamps
    end

    add_index :naics_codes, :code_number, unique: true
  end
end
