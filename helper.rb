require './environment'
require 'twitter'
require 'nextbus'

def client
  @client = Twitter::Client.new(
    :oauth_token => session[:token],
    :oauth_token_secret => session[:secret])
end

class Route

  attr_reader :route, :arrival1, :arrival2

  def initialize(route,arrival1, arrival2)
    @route = route
    @arrival1 = arrival1
    @arrival2 = arrival2
  end

end

def muni_train_lines
  ["N","L","J","M","KT"]
end

def next_n_arrivals(line,stop,n)
  NextBusInterface.arrival_minutes(line,stop)[0,n]
end

def outbound_trains
  muni_train_lines.map  do |line|
    arrivals = next_n_arrivals(line,"6994",2)
    Route.new(line,arrivals[0],arrivals[1])
  end
end