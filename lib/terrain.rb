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

  def self.parse(x, y, string)
    string.split(//).each do |letter|
      Node.find_by_letter(letter).new
    end
  end
end
