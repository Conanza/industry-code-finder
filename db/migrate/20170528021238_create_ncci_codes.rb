class CreateNcciCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :ncci_codes do |t|

      t.timestamps
    end
  end
end
