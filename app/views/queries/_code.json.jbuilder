json.code_number code.code_number
json.general_descriptions GeneralDescription
  .joins(
    base_sys.to_s.singularize.to_sym,
    sys.to_s.singularize.to_sym
  )
  .where("#{base_sys}.code_number" => base_code.code_number)
  .where("#{sys}.code_number" => code.code_number)
  .distinct,
  :description
