require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
  erb :index
end

get '/predict' do 
  @stop = params[:stop]
  @next_arrival = minutes_until_next_arrival("N",@stop)
  @stop = get_stop_title(@stop)
  erb :predict
end

get '/update' do 
  minutes_until_next_arrival("N", "6994")
end  



#HELPERS

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
