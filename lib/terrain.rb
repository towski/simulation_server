class Terrain
  include MongoMapper::Document
  
  key :x, Integer
  key :y, Integer
  key :width, Integer
  key :height, Integer
  key :kind, String

  def contains?(pos)
    pos.x >= x and pos.x <= width and pos.y >= y and pos.y <= height
  end
end
