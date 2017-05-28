class CreateNjCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nj_codes do |t|

      t.timestamps
    end
  end
end
