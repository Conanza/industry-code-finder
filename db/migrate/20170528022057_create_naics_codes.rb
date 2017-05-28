class CreateNaicsCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :naics_codes do |t|

      t.timestamps
    end
  end
end
