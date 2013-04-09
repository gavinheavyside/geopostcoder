DROP TABLE IF EXISTS postcodes_raw;

CREATE TABLE postcodes_raw (
  postcode character varying(10),
  easting character varying(7),
  northing character varying(7)
);

\copy postcodes_raw from pstdin delimiter ',' csv;

DROP TABLE IF EXISTS postcodes;

SELECT
  postcode,
  ST_TRANSFORM(ST_GEOMFROMEWKT('SRID=27700;POINT(' || easting || ' ' || northing || ')'), 4326)::GEOGRAPHY(Point, 4326) AS location
INTO
  postcodes
FROM
  postcodes_raw;

CREATE INDEX postcodes_geog_idx ON postcodes USING GIST(location);

DROP TABLE postcodes_raw;
