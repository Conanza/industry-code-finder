class CreateSicCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :sic_codes do |t|
      t.string :code_number, null: false
      t.timestamps
    end

    add_index :sic_codes, :code_number, unique: true
  end
end
