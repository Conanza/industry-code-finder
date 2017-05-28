# == Schema Information
#
# Table name: naics_codes
#
#  id          :integer          not null, primary key
#  code_number :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class NaicsCode < ApplicationRecord
  has_many :mappings, dependent: :nullify
  has_many :general_descriptions, through: :mappings
  has_many :iso_descriptions, through: :mappings
end
