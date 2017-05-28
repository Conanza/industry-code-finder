class CreateNyCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :ny_codes do |t|
      t.string :code_number, null: false
      t.belongs_to :iso_description, index: true
      t.timestamps
    end

    add_index :ny_codes, :code_number, unique: true
  end
end
