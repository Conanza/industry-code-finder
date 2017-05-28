module Describable
  extend ActiveSupport::Concern

  included do
    has_many :mappings, dependent: :nullify
    has_many :general_descriptions, through: :mappings
    has_many :iso_descriptions, through: :mappings
  end
end
