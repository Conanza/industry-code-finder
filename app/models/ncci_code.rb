# == Schema Information
#
# Table name: ncci_codes
#
#  id          :integer          not null, primary key
#  code_number :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class NcciCode < ApplicationRecord
  include Describable
end
