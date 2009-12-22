class Map 
  include DRb::DRbUndumped
  WIDTH  = 120
  HEIGHT = 40
  attr_reader :animals, :terrain, :x, :y
  def initialize(x, y)
    @x, @y = x, y
    @terrain = Terrain.all("$where" => "(this.x >= #{x} || this.x <= #{x + WIDTH}) && (this.y >= #{y} || this.y <= #{y + HEIGHT})")
    @animals = Animal.all("$where" => "this.x >= #{x} && this.x <= #{x + WIDTH} && this.y >= #{y} && this.y <= #{y + HEIGHT}")
  end

  def grid
    @grid ||= begin 
      the_grid = []
      HEIGHT.times {|i| the_grid[i] = [] }
      @terrain.each do |terrain|
        terrain.height.times do |y|
          terrain.width.times do |x|
            potential_y = y + (terrain.y - 1) - (@y - 1)
            next if potential_y < 0 || potential_y > HEIGHT - 1
            potential_x = x + (terrain.x - 1) - (@x - 1)
            next if potential_x < 0 || potential_x > WIDTH - 1
            the_grid[potential_y][potential_x] = terrain.kind 
          end
        end
      end
      @animals.each do |animal|
        the_grid[animal.y - 1 - @y][animal.x - @x] = animal.species 
      end
      the_grid
    end
  end
end
