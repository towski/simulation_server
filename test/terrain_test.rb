require File.dirname(__FILE__) + '/test_helper'

class MapTest < Test::Unit::TestCase
  it "can be created" do
    terrain = Terrain.create!(:width => 100, :height => 100, :type => "dirt", :x => 1, :y => 1)
  end
end
