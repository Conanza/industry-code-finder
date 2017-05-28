# == Schema Information
#
# Table name: mappings
#
#  id                     :integer          not null, primary key
#  ncci_code_id           :integer
#  ca_code_id             :integer
#  naics_code_id          :integer
#  sic_code_id            :integer
#  general_description_id :integer
#  iso_description_id     :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Mapping < ApplicationRecord
  belongs_to :ca_code, optional: true
  belongs_to :ncci_code, optional: true
  belongs_to :naics_code, optional: true
  belongs_to :sic_code, optional: true
  belongs_to :general_description
  belongs_to :iso_description
end
