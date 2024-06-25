# Simple web server using Sinatra
# Requirements: gem install sinatra rackup
# Usage: rerun server.rb / ruby server.rb
# Access: http://localhost:4567
# Read docs: https://sinatrarb.com/intro.html

require "sinatra"

get '/' do
  'OK'
end

get '/json' do
  { status: 'OK' }.to_json
end

get '/hello' do
  "Hello World!" # Plain text
end

get '/hello/:name' do
  erb :index, locals: { name: params[:name] } # Renders views/index.erb
end

get "/form" do
  ["<form action='/baht' method='get'>",
    "<input name='amount' type='number' placeholder='Enter amount'>",
    "<button>Submit</button>",
    "</form>"].join("\n")
end

# Exercises (Disable Copilot plz 🥲)

# Add a route that accepts query string
# Then use Baht gem to convert the number to Thai words
# Then render the words in JSON format
# URL: http://localhost:4567/baht?amount=123
get '/baht' do
  "TODO"
end

# Add a route that uses httpx gem to get random cat image
# from https://thecatapi.com or https://cataas.com
# Then render the image in erb template
# URL: http://localhost:4567/cat
get '/cat' do
  "TODO"
end
