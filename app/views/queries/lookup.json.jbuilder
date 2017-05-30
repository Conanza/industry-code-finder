json.query_params @query

if @code
  json.cross_references do
    [:ca_codes, :naics_codes, :ncci_codes, :sic_codes].each do |sys|
      next if sys.to_s.singularize.camelcase.constantize == @code.class

      json.set! sys do
        json.array!(@code.send(sys).distinct) do |code|
          json.partial! 'queries/code', locals: {
            code: code,
            sys: sys,
            base_code: @code,
            base_sys: @code.class.name.underscore.pluralize.to_sym
          }
        end
      end
    end

    json.iso_descriptions @code.iso_descriptions.distinct, :description
    json.general_descriptions @code.general_descriptions.distinct, :description
  end
end
