# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"

# Could not dump table "planet_osm_line" because of following StandardError
#   Unknown type 'geometry(LineString,900913)' for column 'way'

# Could not dump table "planet_osm_point" because of following StandardError
#   Unknown type 'geometry(Point,900913)' for column 'way'

# Could not dump table "planet_osm_polygon" because of following StandardError
#   Unknown type 'geometry(Geometry,900913)' for column 'way'

# Could not dump table "planet_osm_roads" because of following StandardError
#   Unknown type 'geometry(LineString,900913)' for column 'way'

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

end
