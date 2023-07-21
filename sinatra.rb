require 'sinatra'
require 'json'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end

post '/debug' do
  request.body.rewind
  data = JSON.parse request.body.read
  ts = Time.now
  
  # Append data to log
  File.open('log/server.log', 'a+') { |f|
    f.puts "#### #{ts} ####"
    f.puts data.to_json
  }
  File.open("log/#{ts.to_i}-#{ts.usec}.json", 'a+') { _1.puts JSON.pretty_generate(data) }

  status 200
end

