$LOAD_PATH.unshift(File.expand_path('.'))
require 'sinatra'
require 'active_record'

set :database, ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "sqlite3:///db/poodles.db")




get '/' do
  erb :index
end