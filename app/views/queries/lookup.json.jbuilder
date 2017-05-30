# json.query_params @results[:query_params]


if @code
  json.iso_descriptions @code.iso_descriptions.distinct do |d|
    json.description d.description
  end

  json.general_descriptions @code.general_descriptions.distinct do |d|
    json.description d.description
  end
end
