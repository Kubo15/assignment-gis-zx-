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
      'select ST_AsGeoJSON(ST_Transform(r.way,4326)) as data from forests
	      cross join routes as r
        where  (ST_Touches(r.way,forests.way))'
  )

  @@raw_con.prepare(
      'water_ways',
      'select ST_AsGeoJSON(ST_Transform(r.way,4326)) as data from routes as r
	      cross join waters as w
	      where ST_DWithin(
	        ST_Transform(w.way,4326)::geography,
	        ST_Transform(r.way,4326)::geography,
	        $1 )'
  )

  @@raw_con.prepare(
      'hist_ways',
      'select ST_AsGeoJSON(ST_Transform(r.way,4326)) as data from routes as r
	        cross join viewpoints as v
	        where ST_DWithin(
	          ST_Transform(v.way,4326)::geography,
	          ST_Transform(r.way,4326)::geography,
	          $1 )'
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

  def self.comp_routes( comp_params )

    f =  @@raw_con.exec_prepared('forest_ways') if comp_params[:forest][:checked] === "true"
    w =  @@raw_con.exec_prepared('water_ways',[comp_params[:water][:dist]]) if comp_params[:water][:checked] === "true"
    h =  @@raw_con.exec_prepared('hist_ways',[comp_params[:historical][:dist]]) if comp_params[:historical][:checked] === "true"

    res = f.to_a
    res = w.to_a if f.nil?
    res = h.to_a if f.nil? and w.nil?

    res = res & w.to_a  unless w.nil? or f.nil?
    res = res & h.to_a  unless h.nil? or (w.nil? and f.nil?)

    res

  end



end