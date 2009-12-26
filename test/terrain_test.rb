require File.dirname(__FILE__) + '/test_helper'

class MapTest < Test::Unit::TestCase
  before do
    Terrain.delete_all
  end

  it "can be created" do
    terrain = Terrain.create!(:width => 100, :height => 100, :type => "dirt", :x => 1, :y => 1)
  end

  it "validates no two terrain can occupy the same spot" do
    Terrain.create!(:x => 1, :y => 1)
    terrain = Terrain.new(:x => 1, :y => 1)
    terrain.valid?.should == false
  end

  it "validates no two terrain can occupy the same area" do
    Terrain.create!(:x => 1, :y => 1, :width => 2, :height => 2)
    terrain = Terrain.new(:x => 2, :y => 2)
    terrain.valid?.should == false
  end

  it "validates no two terrain can occupy the same area 2" do
    Terrain.create!(:x => 1, :y => 1, :width => 3, :height => 3)
    terrain = Terrain.new(:x => 2, :y => 2)
    terrain.valid?.should == false
  end
  
  it "parses a string to create terrain" do
    Terrain.parse(".^~")
    all_terrain = Terrain.all
    all_terrain[0].kind.should == "Plains"
    all_terrain[0].position.should == Position.new(1,1)
    all_terrain[1].kind.should == "Mountain"
    all_terrain[1].position.should == Position.new(2,1)
    all_terrain[2].kind.should == "Water"
    all_terrain[2].position.should == Position.new(3,1)
  end
end
