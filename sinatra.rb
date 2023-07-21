require 'sinatra'
require 'json'

post '/debug' do
  request.body.rewind
  data = JSON.parse request.body.read
  
  # Append data to log
  File.open('log/server.log', 'a+') { |f|
    f.puts "#### #{Time.now} ####"
    f.puts data
  }

  status 200
end

