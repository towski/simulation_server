require File.dirname(__FILE__) + '/test_helper'

class UserTest < Test::Unit::TestCase
  it "returns the area for the current_user" do
    user = User.create :x => 1, :y => 1
    animal = user.animals.create :species => "homo sapien", :x => 1, :y => 1
    assert_equal [animal], user.map.animals
  end
end
