class PostGis

  @@raw_con = ActiveRecord::Base.connection.raw_connection

  @@raw_con.prepare(
      'all_routes',
      'SELECT ST_AsGeoJSON(ST_Transform(way,4326)) as data
            from planet_osm_line
            where route like $1 or bicycle like $2'
  )

  @@raw_con.prepare(
      'all_hist',
      "select ST_AsGeoJSON(ST_Transform(way,4326)) as data, name
	          from planet_osm_point
	          where (tourism = 'viewpoint' or historic is not null)
	          and name is not null"
  )

  @@raw_con.prepare(
      'near_routes',
      "SELECT ST_AsGeoJSON(ST_Transform(way,4326)) as data
            from planet_osm_line
            where (route like 'bicycle' or bicycle like 'yes')
            and ST_DWithin(
              ST_Transform(way,4326)::geography,
              ST_SetSRID(ST_Point($1, $2),4326)::geography,
              $3 )"
  )

  @@raw_con.prepare(
      'forest_ways',
      'select routes.way from forests
	      cross join routes
        where  (ST_Touches(routes.way,forests.way))'
  )

  @@raw_con.prepare(
      'forest_ways',
      'select routes.way from forests
	      cross join routes
        where  (ST_Touches(routes.way,forests.way))'
  )

  def self.test_query

    query = "select * from planet_osm_line limit 100"
    ActiveRecord::Base.connection.execute(query)

  end

  def self.all_routes

    @@raw_con.exec_prepared 'all_routes', ['bicycle','yes']

  end

  def self.all_historic

    @@raw_con.exec_prepared 'all_hist'

  end

  def self.near_routes( pos_params )

    @@raw_con.exec_prepared(
        'near_routes',
        [ pos_params[:long], pos_params[:lat], pos_params[:dist] ]
    )

  end

  def self.PostGis( comp_routes )

    

  end

end