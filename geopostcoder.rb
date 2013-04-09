require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'haml'
require_relative 'lib/geocoder'

class GeoPostCoder < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  use Rack::CommonLogger

  get '/' do
    haml :index
  end

  post '/postcode' do
    @lat = params[:lat]
    @lng = params[:lng]

    geocoder = Geocoder.new
    @postcode = geocoder.lookup_postcode_by_lat_lng(@lat, @lng)

    haml :postcode
  end
end
