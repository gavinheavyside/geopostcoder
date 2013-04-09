require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'haml'

class GeoPostCoder < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  use Rack::CommonLogger

  get '/' do
    haml :index
  end

  post '/postcode' do
    @lat = params[:lat]
    @lng = params[:lng]

#    @postcode = reverse_geocode_postcode(@lat, @lng)

    haml :postcode
  end
end
