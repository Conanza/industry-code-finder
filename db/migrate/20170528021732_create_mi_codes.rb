class CreateMiCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :mi_codes do |t|

      t.timestamps
    end
  end
end
