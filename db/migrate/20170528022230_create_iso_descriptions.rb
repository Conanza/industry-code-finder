class CreateIsoDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :iso_descriptions do |t|
      t.string :description, null: false
      t.timestamps
    end

    add_index :iso_descriptions, :description, unique: true
  end
end
