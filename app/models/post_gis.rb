class PostGis

  def self.test_query

    query = "select * from planet_osm_line limit 100"
    results = ActiveRecord::Base.connection.execute(query)

  end

  def self.all_routes

    q = "SELECT ST_AsGeoJSON(ST_Transform(way,4326)) as data
            from planet_osm_line
            where route like 'bicycle' or bicycle like 'yes'"

    results = ActiveRecord::Base.connection.execute(q)

  end

  def self.all_historic

    q = "select ST_AsGeoJSON(ST_Transform(way,4326)) as data, name
	          from planet_osm_point
	          where (tourism = 'viewpoint' or historic is not null)
	          and name is not null"

    results = ActiveRecord::Base.connection.execute(q)

  end

end