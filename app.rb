$LOAD_PATH.unshift(File.expand_path('.'))
require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'active_record'
require './environment'
require 'omniauth-twitter'
require 'dotenv'
require_relative './models/user'

Dotenv.load

set :database, ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "sqlite3:///db/stopmotion.db")
enable :sessions

use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end

get '/' do
  erb :index
end

get '/predict' do 
  @stop = params[:stop]
  @next_arrival = minutes_until_next_arrival("N",@stop)
  @stop = get_stop_title(@stop)
  erb :index
end

get '/update' do 
  minutes_until_next_arrival("N", "6994")
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  u = User.new(params[:user])
  u.password = params[:password]
  u.save!
  redirect('/')
end

get '/auth/twitter/callback' do
  session[:token] = env['omniauth.auth'].credentials.token
  session[:secret] = env['omniauth.auth'].credentials.secret
  redirect '/'
end


get '/map' do
  erb :map
end

def minutes_until_next_arrival(line, stop)
  predictions = Nokogiri::XML(open("http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=N&s=#{stop}"))
  prediction_nodes = predictions.xpath('.//prediction')
  prediction_minutes = prediction_nodes.map {|prediction| prediction[:minutes]}
  prediction_minutes[0]
end


def get_stop_title(stop_tag)
  @stop_tags_and_titles = {"6994" => "Montgomery" ,"6995" => "Powell" ,"7217" => "Embarcadero"}
  @stop_tags_and_titles[stop_tag]
end

