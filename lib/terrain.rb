class Terrain
  include MongoMapper::Document

  validate :no_overlapping_terrain

  def no_overlapping_terrain
    if self.class.count("$where" => "(this.x >= #{x} || this.x + this.width - 1 >= #{x}) && (this.y >= #{y} || this.y + this.height - 1 >= #{y})") != 0
      errors.add(:base, "HEY")
    end
  end

  def self.within(start, finish)
    all("$where" => "(this.x >= #{start.x} || this.x <= #{finish.x}) && (this.y >= #{start.y} || this.y <= #{finish.y})")
  end
  
  key :x, Integer
  key :y, Integer
  key :width, Integer, :default => 1
  key :height, Integer, :default => 1
  key :kind, String

  def contains?(pos)
    pos.x >= x and pos.x <= width and pos.y >= y and pos.y <= height
  end

  def position
    @position ||= Position.new(x, y)
  end

  def self.parse(string, x_start = 1, y_start = 1)
    x_spot = 0
    string.split(//).each do |letter|
      terrain = find_or_initialize_by_x_and_y x_start + x_spot, y_start
      terrain.kind = Node.by_letter(letter).name
      terrain.save!
      x_spot += 1
    end
  end
end
