select ST_AsGeoJSON(ST_Transform(way,4326)) as data, name 
	from planet_osm_point 
	where (tourism = 'viewpoint' or historic is not null) 
	and name is not null

SELECT ST_AsGeoJSON(ST_Transform(way,4326)) as data
            from planet_osm_line
            where (route like 'bicycle' or bicycle like 'yes')
            and ST_DWithin( way::geography,ST_Point(17.199268341064453, 48.142036125223214)::geography, 10000 );

CREATE MATERIALIZED VIEW forests AS 
    select * from planet_osm_polygon where landuse like 'forest' or landuse like 'wood'

CREATE MATERIALIZED VIEW waters AS 
    select * from planet_osm_line where water is not null or waterway is not null

CREATE MATERIALIZED VIEW viewpoints AS 
    select * from planet_osm_point 
	where (tourism = 'viewpoint' or historic is not null) 
	and name is not null
	
CREATE MATERIALIZED VIEW routes AS 
    select * from planet_osm_line
            where (route like 'bicycle' or bicycle like 'yes')

CREATE INDEX gix_road_geo ON planet_osm_line USING GIST (way);
CREATE INDEX index_line_route ON planet_osm_line(route)

with (

  select routes.way from forests 
	cross join routes	
        where  (ST_Touches(routes.way,forests.way))
	and false;
	
) as forest_ways, (

  select r.way from routes as r
	cross join waters as w
	where ST_DWithin( 
	  ST_Transform(w.way,4326)::geography, 
	  ST_Transform(r.way,4326)::geography, 
	  150 )
	and false
	
) as water_ways, (

  select r.way from routes as r
	cross join viewpoints as v
	where ST_DWithin( 
	  ST_Transform(v.way,4326)::geography, 
	  ST_Transform(r.way,4326)::geography, 
	  150 )
	and false

) as hist_ways



create index index_r_transf on planet_osm_line(ST_Transform(way,4326))

CREATE MATERIALIZED VIEW vsetko AS 
	select 
		wline.way as water_way, 
		fpoly.way as forest_way,
		hpoint.way as poi_way,
		rline.way as road_way 
		 
	from planet_osm_line as wline 	
	cross join planet_osm_polygon as fpoly
	cross join planet_osm_point as hpoint
	cross join planet_osm_line as rline
	
	where ((wline.water is not null or wline.waterway is not null )
		or ( fpoly.landuse like 'forest' or fpoly.landuse like 'wood' )
		or ( fpoly.landuse like 'forest' or fpoly.landuse like 'wood' )
		or ( ( hpoint.tourism = 'viewpoint' or hpoint.historic is not null ) 
			and hpoint.name is not null ))
	and 
		( ST_DWithin( ST_Transform(wline.way,4326)::geography, ST_Transform(rline.way,4326)::geography , 5000 )
		  or ST_Touches(rline.way, fpoly.way)
		  or ST_DWithin( ST_Transform(rline.way,4326)::geography, ST_Transform(hpoint.way,4326)::geography , 5000 )
		 )

	limit 1000

















		 