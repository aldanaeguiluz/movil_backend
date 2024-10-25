require 'sinatra'
require 'json'

get '/usuario' do
  Usuario.all.to_json
end