ENV["APP_ENV"]="test"
require 'main'
#require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test/unit'
require 'context'
require 'matchy'
require 'ruby-debug'
require 'rr'
#require File.join(File.dirname(__FILE__), 'blueprints')

class Test::Unit::TestCase
  include RR::Adapters::RRMethods
end

