class User < ActiveRecord::Base
  has_many :animals

  def map
    Map.new(x,y)
  end
end
