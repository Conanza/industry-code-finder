class QueriesController < ApplicationController
  def test
    render json: { msg: "testing testes 1 2 balls" }
  end

  def lookup
    class_system = query_params[:class_system].downcase
    code_class = "#{class_system}_code".camelcase.constantize
    @code = code_class.find_by(code_number: query_params[:code_number])

    # @results = {
    #   query_params: {
    #     classification_system: query_params[:class_system],
    #     code_number: query_params[:code_number]
    #   },
    #   cross_references: {
    #     ca: {},
    #     naics: {},
    #     ncci: {},
    #     sic: {}
    #   },
    #   descriptions: {
    #     iso: {},
    #     general: {}
    #   }
    # }
  end

  private

  def query_params
    params.require(:query).permit(:class_system, :code_number)
  end
end
