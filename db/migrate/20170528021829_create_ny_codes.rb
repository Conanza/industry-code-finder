class CreateNyCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :ny_codes do |t|

      t.timestamps
    end
  end
end
