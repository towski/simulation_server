class Map 
  include DRb::DRbUndumped
  WIDTH  = 120
  HEIGHT = 40
  attr_reader :animals, :terrain
  def initialize(x, y)
    @terrain = Terrain.all(:conditions => ["x >= ? and x < ? and y >= ? and y < ?", x, x + WIDTH, y, y + HEIGHT])
    @animals = Animal.all(:conditions => ["x >= ? and x < ? and y >= ? and y < ?", x, x + WIDTH, y, y + HEIGHT])
  end

  def grid
    @grid ||= begin 
      grid = []
      HEIGHT.times {|i| grid[i] = [] }
      @terrain.each do |terrain|
        terrain.height.times do |x|
          terrain.width.times do |y|
            grid[x + (terrain.x - 1)][y + (terrain.y - 1)] = terrain.kind 
          end
        end
      end
      @animals.each do |animal|
        grid[animal.x - 1][animal.y - 1] = animal.species 
      end
      grid
    end
  end
end
