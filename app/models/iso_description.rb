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
end
