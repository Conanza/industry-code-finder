class CreateCaCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :ca_codes do |t|

      t.timestamps
    end
  end
end
