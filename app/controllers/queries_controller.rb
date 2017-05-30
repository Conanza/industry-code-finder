class QueriesController < ApplicationController
  def new
  end

  def lookup
    @query = query_params
    class_system = @query[:class_system].downcase
    code_class = "#{class_system}_code".camelcase.constantize
    @code = code_class.find_by(code_number: @query[:code_number])

    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  private

  def query_params
    params.require(:query).permit(:class_system, :code_number)
  end
end
