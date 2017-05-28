# == Schema Information
#
# Table name: iso_descriptions
#
#  id          :integer          not null, primary key
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class IsoDescription < ApplicationRecord
  has_many :mappings
  has_many :ca_codes, through: :mappings
  has_many :ncci_codes, through: :mappings
  has_many :naics_codes, through: :mappings
  has_many :sic_codes, through: :mappings
  has_many :general_descriptions, through: :mappings

  def self.to_label
    'ISO Description'
  end
end
