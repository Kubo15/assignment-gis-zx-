class PostGis

  def self.test_query

    query = "select * from planet_osm_line limit 100"
    results = ActiveRecord::Base.connection.execute(query)

  end

  def self.all_routes

    q = "SELECT ST_AsGeoJSON(ST_Transform(way,4326)) as data from planet_osm_line where route like 'bicycle' or bicycle like 'yes'"
    results = ActiveRecord::Base.connection.execute(q)

  end

end