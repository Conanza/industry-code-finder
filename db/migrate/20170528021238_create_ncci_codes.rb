class CreateNcciCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :ncci_codes do |t|
      t.string :code_number, null: false
      t.timestamps
    end

    add_index :ncci_codes, :code_number, unique: true
  end
end
