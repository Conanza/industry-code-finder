# == Schema Information
#
# Table name: sic_codes
#
#  id          :integer          not null, primary key
#  code_number :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SicCode < ApplicationRecord
  include Describable

  def self.to_label
    'SIC'
  end
end
