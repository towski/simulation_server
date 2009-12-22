require File.dirname(__FILE__) + '/test_helper'

class PathTest < Test::Unit::TestCase
  it "works for simple terrains" do
    Terrain.delete_all
    start = Animal.new(:x => 1, :y => 1)
    goal = Animal.new(:x => 4, :y => 1)
    Terrain.create(:kind => "flatland", :x => 1, :y => 1, :width => 4, :height => 1)
    path = Path.new(:start => start, :goal => goal)
    path.calculate
    path.save
    path.nodes.size.should == 4
    assert_equal %q(####), path.to_s
  end

  #def test_simple_vertical
  #  map = Map.new %q(@..X).split(//).join("\n")
  #  map.solve!
  #  assert_paths_equal(%Q(#\n#\n#\n#), map.to_s)
  #end

  #def test_quiz_statement
  #  map = Map.new %q(@*^^^
  #                   ~~*~.
  #                   **...
  #                   ^..*~
  #                   ~~*~X).sub(/ +/,'')
  #  map.solve!
  #  assert_paths_equal(
  #     %q(##^^^
  #        ~~#~.
  #        **??.
  #        ^..#~
  #        ~~*~#), map.to_s, "Didn't do test solution")
  #end
end
