require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
  erb :index
end

get '/predict' do 
  @next_arrival = predict_n_montogomery
  erb :predict
end




#HELPERS

def predict_n_montogomery
  predictions = Nokogiri::XML(open('http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=N&s=6994'))
  prediction_nodes = predictions.xpath('.//prediction')
  prediction_minutes = prediction_nodes.map {|prediction| prediction[:minutes]}
  prediction_minutes[0]
end