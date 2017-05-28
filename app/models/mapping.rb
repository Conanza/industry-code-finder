# == Schema Information
#
# Table name: mappings
#
#  id                     :integer          not null, primary key
#  ncci_code_id           :integer
#  ca_code_id             :integer
#  de_code_id             :integer
#  mi_code_id             :integer
#  nj_code_id             :integer
#  ny_code_id             :integer
#  pa_code_id             :integer
#  tx_code_id             :integer
#  naics_code_id          :integer
#  sic_code_id            :integer
#  iso_cgl_code_id        :integer
#  general_description_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Mapping < ApplicationRecord
end
