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
  { status: 'Hi' }.to_json
end

get '/hello' do
  "Hello World!" # Plain text
end

# http://localhost:4567/hello/noom?age=20
get '/hello/:name' do
  puts params
  erb :index, locals: { name: params[:name] } # Renders views/index.erb
end

# http://localhost:4567/form
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
require "baht"
get '/baht' do
  amount = params[:amount]

  { baht: Baht.words(amount) }.to_json
end

# Add a route that uses httpx gem to get random cat image
# from https://thecatapi.com or https://cataas.com
# Then render the image in erb template
# URL: http://localhost:4567/cat
require "httpx"
get '/cat' do
  url = "https://api.thecatapi.com/v1/images/search?size=med
  &mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1"

  response = HTTPX.get(url)

  puts response.json
  # [{"id"=>"j5cVSqLer", "url"=>"https://cdn2.thecatapi.com/images/j5cVSqLer.jpg", "width"=>1600, "height"=>1200}]
  image_url = response.json[0]["url"] # not [:url]

  erb :cat, locals: { url: image_url }
end

get '/cataas' do
  url = "https://cataas.com/cat?json=true"

  response = HTTPX.get(url)

  puts response.json
  # {"tags"=>[], "createdAt"=>"2021-07-27T23:51:21.696Z", "updatedAt"=>"2022-10-11T07:52:32.546Z", "mimetype"=>"image/jpeg", "size"=>357116, "_id"=>"18MD6byVC1yKGpXp"}

  id = response.json["_id"]
  image_url = "https://cataas.com/cat/#{id}"

  erb :cat, locals: { url: image_url }
end
