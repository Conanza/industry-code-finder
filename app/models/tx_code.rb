# == Schema Information
#
# Table name: tx_codes
#
#  id                 :integer          not null, primary key
#  code_number        :string           not null
#  iso_description_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class TxCode < ApplicationRecord
end
