class HomeController < ApplicationController

  def index
  end

  def test_query

    render json: PostGis.test_query

  end

  def all_routes

    render json: PostGis.all_routes

  end

end
