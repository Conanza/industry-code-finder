module Describable
  extend ActiveSupport::Concern

  included do
    has_many :mappings, dependent: :nullify
    has_many :general_descriptions, through: :mappings
    has_many :iso_descriptions, through: :mappings

    [:ca_codes, :naics_codes, :ncci_codes, :sic_codes].each do |code|
      next if code == name.underscore.pluralize.to_sym
      has_many code, through: :mappings
    end
  end
end
