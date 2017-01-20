class LocationsController < ApplicationController
  def show
    country_code = CS.countries.invert[params[:id]]
    @cities = CS.states(country_code).values
    render json: @cities.as_json
  end
end
