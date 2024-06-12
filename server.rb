# Simple web server using Sinatra
# Requirements: gem install sinatra rackup
# Usage: ruby server.rb

require "sinatra"

get '/' do
  'Hello world!'
end

get '/hello/:name' do
  "<h1>Hello #{params['name'].capitalize}!</h1>"
end
