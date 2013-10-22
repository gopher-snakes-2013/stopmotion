$LOAD_PATH.unshift(File.expand_path('.'))
require 'sinatra'
require 'active_record'
require './environment'
require 'omniauth-twitter'

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

  erb :index
end

