APP_ROOT = "#{File.dirname(__FILE__)}"
APP_ENV = ENV["APP_ENV"] || "development"
require 'drb/drb'
require 'rubygems'
require 'activerecord'
require 'ruby-debug'
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.send :include, DRb::DRbUndumped
ActiveRecord::Base.establish_connection("adapter"  => "mysql", 
   "database" => APP_ENV == "development" ? "drb" : "drb_test", 
   "host"    => "localhost",
   "username" => "root",
   "password" => "",
   "socket"   => "/private/tmp/mysql.sock")
Dir['lib/*'].each {|file| require file }
