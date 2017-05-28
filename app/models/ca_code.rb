# == Schema Information
#
# Table name: ca_codes
#
#  id          :integer          not null, primary key
#  code_number :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CaCode < ApplicationRecord
  has_many :mappings, dependent: :nullify
  has_many :general_descriptions, through: :mappings
end
