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
  has_one :mapping
  has_one :ca_code, through: :mapping
  has_one :ncci_code, through: :mapping
  has_one :naics_code, through: :mapping
  has_one :sic_code, through: :mapping
  has_one :iso_description, through: :mapping

  def self.to_label
    'General Description'
  end
end
