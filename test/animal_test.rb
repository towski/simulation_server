require File.dirname(__FILE__) + '/test_helper'

class AnimalTest < Test::Unit::TestCase
  it "returns the area for the current_user" do
    user = User.create :x => 10, :y => 10
    user.map.animals.should == [user]
  end
end
