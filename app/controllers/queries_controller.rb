class QueriesController < ApplicationController
  def test
    render json: { msg: "testing testes 1 2 balls" }
  end

  def test2
    render json: { msg: 'second test'}
  end
end
