require 'rubygems'
require 'ruby-debug'
require 'drb/drb'
require 'mongo_mapper'
APP_ROOT = "#{File.dirname(__FILE__)}"
APP_ENV = ENV["APP_ENV"] || "development"
config = YAML.load_file(APP_ROOT + "/config/database.yml")[APP_ENV]
 
MongoMapper.connection = Mongo::Connection.new(config['host'], config['port'], {
  :logger => Logger.new(STDOUT)
})
 
MongoMapper.database = config['database']
if config['username'].present?
  MongoMapper.database.authenticate(config['username'], config['password'])
end
 
Dir[APP_ROOT + '/lib/*.rb'].each do |model_path|
  require model_path
#Dir['lib/animal.rb', 'lib/user.rb', 'lib/terrain.rb', 'lib/map.rb'].each do |model_path|
#  File.basename(model_path, '.rb').classify.constantize
end
#MongoMapper.ensure_indexes!
