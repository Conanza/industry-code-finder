class CreateTxCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :tx_codes do |t|

      t.timestamps
    end
  end
end
