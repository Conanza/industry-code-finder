class CreateMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :mappings do |t|
      t.belongs_to :ncci_code, index: true
      t.belongs_to :ca_code, index: true
      t.belongs_to :de_code, index: true
      t.belongs_to :mi_code, index: true
      t.belongs_to :nj_code, index: true
      t.belongs_to :ny_code, index: true
      t.belongs_to :pa_code, index: true
      t.belongs_to :tx_code, index: true
      t.belongs_to :naics_code, index: true
      t.belongs_to :sic_code, index: true
      t.belongs_to :iso_cgl_code, index: true
      t.belongs_to :general_description, index: true
      t.belongs_to :iso_description, index: true

      t.timestamps
    end

    add_index :mappings,
              [
                :ncci_code_id, :ca_code_id, :de_code_id,
                :mi_code_id, :nj_code_id, :ny_code_id,
                :pa_code_id, :tx_code_id, :naics_code_id,
                :sic_code_id, :iso_cgl_code_id,
                :general_description_id,
                :iso_description_id
              ],
              unique: true,
              name: 'by_descriptions_codes'
  end
end
