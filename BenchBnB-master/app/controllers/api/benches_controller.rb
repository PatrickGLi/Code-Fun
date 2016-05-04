class Api::BenchesController < ApplicationController
  def index
    @benches = Bench.in_bounds(bound_params)
  end

  def create
    @bench = Bench.new(data_params);
    @bench.save!
    #
    # if @bench.save
    #   render json: @bench
    # else
    #   render json: @bench, status: 422

    render :show
  end

  private

  def bound_params
    params.require(:bounds).permit(:northBound, :eastBound, :southBound, :westBound)
  end

  def data_params
    params.require(:bench).permit(:lat, :lng, :seating, :description)
  end

end
