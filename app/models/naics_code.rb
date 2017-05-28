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
  include Describable

  def self.to_label
    'NAICS'
  end
end
