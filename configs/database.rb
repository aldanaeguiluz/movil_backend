require 'sequel'

DB = Sequel.sqlite('db/app.db')
Sequel::Model.plugin :json_serializer