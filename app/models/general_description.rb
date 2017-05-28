# == Schema Information
#
# Table name: general_descriptions
#
#  id          :integer          not null, primary key
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GeneralDescription < ApplicationRecord
  has_one :mapping, dependent: :destroy
  has_one :ca_code, through: :mapping
  has_one :de_code, through: :mapping
  has_one :mi_code, through: :mapping
  has_one :nj_code, through: :mapping
  has_one :ny_code, through: :mapping
  has_one :pa_code, through: :mapping
  has_one :tx_code, through: :mapping
  has_one :ncci_code, through: :mapping
  has_one :naics_code, through: :mapping
  has_one :sic_code, through: :mapping
  has_one :iso_cgl_code, through: :mapping
end
