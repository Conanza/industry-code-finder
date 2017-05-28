class CreateDeCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :de_codes do |t|

      t.timestamps
    end
  end
end
