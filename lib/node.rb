# An (x, y) position on the map
class Position
  attr_accessor :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def ==(other)
    return false unless Position===other
    @x == other.x and @y == other.y
  end

  # Manhattan
  def distance(other)
    (@x - other.x).abs + (@y - other.y).abs
  end

  # Get a position relative to this
  def relative(xr, yr)
    Position.new(x + xr, y + yr)
  end
end

# A map contains a two-dimensional array of nodes
# A node represents a tile in the game
class Node
  include MongoMapper::EmbeddedDocument
  include Comparable # by total_cost

  class << self
    # each node class is defined by a "map letter" and a cost (1, 2, 3)
    attr_accessor :cost, :letter
    
    def other_subclasses
      @@other_subclasses
    end
     
    def inherited(klass)
      super
      @@other_subclasses ||= []
      @@other_subclasses << klass
    end

    def by_name(name)
      other_subclasses.find{|klass| klass.name == name.titleize }
    end
  end

  attr_accessor :parent, :cost, :cost_estimated
  key :on_path, Boolean
  key :x, Integer
  key :y, Integer

  def position
    @position ||= Position.new(x,y)
  end

  def initialize(*args)
    super
    @cost = 0
    @cost_estimated = 0
    @parent = nil
  end

  def mark_path
    self.on_path = true
    @parent.mark_path if @parent
  end

  def walkable?
    true # except Water
  end

  def total_cost
    cost + cost_estimated
  end

  def <=> other
    total_cost <=> other.total_cost
  end

  def == other
    position == other.position
  end

  def to_s
    on_path ? '#' : self.class.letter
  end
end

class Flatland < Node
  self.cost   = 1
end

class Start < Flatland
end

class Goal < Flatland
end

class Water < Node
  def walkable?
    false
  end
end

class Forest < Node
  self.cost   = 2
end

class Mountain < Node
  self.cost   = 3
end

