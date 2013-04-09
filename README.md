# geopostcoder


## Loading Code-Point Open data into your database

First order and download the Code Point Open files from the [Ordnance
Survey](http://www.ordnancesurvey.co.uk/oswebsite/products/code-point-open/)
and unpack them locally. You should get a Data/CSV directory containing a file
for each postcode prefix. In total there were about 1.68 million rows (Q1
2013).

Create your database and install PostGIS extensions (assuming Postgres 9.1+,
PostGIS 2+, and sufficient DB privileges).

    $ createdb geopostcoder
    $ psql -c "CREATE EXTENSION postgis" geopostcoder

Then you can load the Code-Point Open data into your db:

    $ cat /cpo-download/Data/CSV/*.csv | script/load_code_point_open -d <database>

## Running a local server

copy `config/database.yml.example` to `config/database.yml`, and edit it to
match your database name

Install the necessary gems by running `bundle install`, then start the server
with `thin start`.

Point your browser at http://localhost:3000, and try out reverse geocoding some
latitudes and longitudes to UK postcodes.
