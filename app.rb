$LOAD_PATH.unshift(File.expand_path('.'))
require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'active_record'
require './environment'
require 'omniauth-twitter'
require 'dotenv'
require_relative './models/user'
require './helper'

include NextBusInterface

Dotenv.load

set :database, ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "sqlite3:///db/stopmotion.db")
enable :sessions

use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end

get '/' do
  @train_info = outbound_trains
  erb :index
end

get '/update' do
  outbound_trains_json.to_json
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






