class CreateGeneralDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :general_descriptions do |t|
      t.string :description, null: false
      t.timestamps
    end

    add_index :general_descriptions, :description, unique: true
  end
end
