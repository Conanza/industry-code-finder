class CreateGeneralDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :general_descriptions do |t|

      t.timestamps
    end
  end
end
