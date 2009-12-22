class User
  include MongoMapper::Document

  key :x, Integer
  key :y, Integer

  many :animals

  def map
    Map.new(x,y)
  end
end
