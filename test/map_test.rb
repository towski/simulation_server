require File.dirname(__FILE__) + '/test_helper'

class MapTest < Test::Unit::TestCase
  context "building" do
    it "returns the map" do
      terrain = Terrain.create!(:width => 120, :height => 40, :kind => "dirt", :x => 1, :y => 1)
      human = Animal.create!(:x => 1, :y => 1, :species => "homo sapien")
      map = Map.new(1,1)
      assert_equal [human], map.animals
      assert_equal [terrain], map.terrain
      first_row = ["homo sapien"] + ["dirt"] * 119
      all_dirt = ["dirt"] * 120
      assert_equal first_row, map.grid[0]
      assert_equal [all_dirt] * 39, map.grid[1..39]
    end

    it "has terrain that is only a subset of the viewed area" do
      terrain = Terrain.create!(:width => 10, :height => 10, :kind => "dirt", :x => 1, :y => 1)
      map = Map.new(1,2)
      assert_equal [terrain], map.terrain
      assert_equal "dirt", map.grid[0][0]
      assert_equal [], map.grid[9]
    end
  end
end
