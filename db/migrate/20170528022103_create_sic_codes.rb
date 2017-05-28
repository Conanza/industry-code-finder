class CreateSicCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :sic_codes do |t|

      t.timestamps
    end
  end
end
