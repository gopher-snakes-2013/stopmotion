$LOAD_PATH.unshift(File.expand_path('.'))
require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'active_record'
require './environment'
require 'omniauth-twitter'
require 'dotenv'

Dotenv.load

set :database, ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "sqlite3:///db/poodles.db")
enable :sessions


get '/' do
  erb :index
end


use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end

get '/auth/twitter/callback' do
  session[:token] = env['omniauth.auth'].credentials.token
  session[:secret] = env['omniauth.auth'].credentials.secret
  redirect '/'
  # erb :index
end

get '/map' do

  erb :map
end

get '/predict' do 
  @next_arrival = predict_n_montogomery
  erb :predict
end

def predict_n_montogomery
  predictions = Nokogiri::XML(open('http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=N&s=6994'))
  prediction_nodes = predictions.xpath('.//prediction')
  prediction_minutes = prediction_nodes.map {|prediction| prediction[:minutes]}
  prediction_minutes[0]
end


