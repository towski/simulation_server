APP_ROOT = "#{File.dirname(__FILE__)}"
require 'drb/drb'
require 'rubygems'
require 'activerecord'
require 'ruby-debug'
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.send :include, DRb::DRbUndumped
ActiveRecord::Base.establish_connection("adapter"  => "mysql", 
   "database" => "drb", 
   "host"    => "localhost",
   "username" => "root",
   "password" => "",
   "socket"   => "/private/tmp/mysql.sock")
Dir['lib/*'].each {|file| require file }
