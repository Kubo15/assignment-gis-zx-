class HomeController < ApplicationController

  def index
  end

  def test_query

    render json: PostGis.test_query

  end

  def all_routes

    render json: PostGis.all_routes

  end

  def all_hist

    render json: PostGis.all_historic

  end

  def near_routes

    render json: PostGis.near_routes( pos_params )

  end

  def comp_routes

    render json: PostGis.comp_routes( comp_params )

  end

  private

    def pos_params
      params.require(:position).permit(:lat, :long, :dist)
    end

    def comp_params
      params.require(:data).permit(
          forest:[:checked],
          water: [:checked,:dist],
          historical: [:checked,:dist]
      )
    end

end
