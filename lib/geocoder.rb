require 'pg'
require 'yaml'

class Geocoder
  ONE_KM_IN_METRES = 1000

  def initialize
    @dbconn = PG.connect(config[ENV['RACK_ENV'] || 'development'])
  end

  def lookup_postcode_by_lat_lng(lat, lng)
    point_as_wkt = "SRID=4326;POINT(#{lng} #{lat})"

    query = """
SELECT
  postcode,
  ST_DISTANCE(location, ST_GEOGRAPHYFROMTEXT('#{point_as_wkt}')) AS distance
FROM
  postcodes
WHERE
  ST_DWITHIN(location, ST_GEOGRAPHYFROMTEXT('#{point_as_wkt}'), #{ONE_KM_IN_METRES})
ORDER BY
  distance, postcode
LIMIT
  1
"""
    $stderr.puts query

    @dbconn.exec(query) do |res|
      res.first["postcode"] if res.ntuples == 1
    end
  end

  private

  def config
    @config ||= YAML.load_file(File.expand_path('../../config/database.yml', __FILE__))
  end
end
