require './environment'
require 'twitter'


def client
  @client = Twitter::Client.new(
    :oauth_token => session[:token],
    :oauth_token_secret => session[:secret])
end