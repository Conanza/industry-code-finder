class QueriesController < ApplicationController
  def test
    render json: {
      data: "testing testes 1 2 balls"
    }
  end

  def test2
    render json: { data: 'second test'}
  end
end
