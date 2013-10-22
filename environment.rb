require 'twitter'


ENV['CONSUMER_KEY'] = 'RXl4gTWWvrF5PFXgUAf1w'
ENV['CONSUMER_SECRET'] = 'NGjlYAU2FXxd5QiCIokefoErZfQgm19f9rLOzlox1w'

Twitter.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
end
