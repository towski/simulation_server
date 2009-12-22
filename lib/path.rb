class Path
  include MongoMapper::Document
  include Enumerable # for find

  #many :nodes
  many :nodes

  def build_nodes
    @terrain = Terrain.all("$where" => "(this.x >= #{start.x} || this.x <= #{goal.x}) && (this.y >= #{start.y} || this.y <= #{goal.y})")
    @node_grid = []
    @width  = goal.x - start.x + 1
    @height = goal.y - start.y + 1
    @height.times do |y|
      @node_grid[y] = []
      @width.times do |x|
        terrain = @terrain.find {|t| t.contains?(Position.new(start.x + x, start.y + y)) }
        new_node = Node.by_name(terrain.kind).new(:x => x, :y => y)
        @node_grid[y] << new_node
        nodes << new_node
      end
    end
    @node_grid[0][0] = Start.new(:x => 0, :y => 0)
    @node_grid[@height - 1][@width - 1] = Goal.new(:x => @width - 1, :y => @height - 1)
  end

  # Returns true if the given position is on the map
  def contains?(pos)
    pos.x >= 0 and pos.x < @width and pos.y >= 0 and pos.y < @height
  end

  # Return node at position
  def at(pos)
    @node_grid[pos.y][pos.x]
  end

  # Iterate all nodes
  def each
    @node_grid.each do |row|
      row.each do |node|
        yield(node)
      end
    end
  end

  # Iterates through all adjacent nodes
  def each_neighbour(node)
    pos = node.position
    yield_it = lambda{|p| yield(at(p)) if contains? p} # just a shortcut
    yield_it.call(pos.relative(-1, -1))
    yield_it.call(pos.relative( 0, -1))
    yield_it.call(pos.relative( 1, -1))
    yield_it.call(pos.relative(-1,  0))
    yield_it.call(pos.relative( 1,  0))
    yield_it.call(pos.relative(-1,  1))
    yield_it.call(pos.relative( 0,  1))
    yield_it.call(pos.relative( 1,  1))
  end

  def calculate
    build_nodes
    map = self
    start = map.find{|node| Start === node}
    goal  = map.find{|node| Goal  === node}
    open_set   = [start] # all nodes that are still worth examining
    closed_set = []      # nodes we have already visited

    loop do
      current = open_set.min # find node with minimum cost
      raise "There is no path from #{start} to #{goal}" unless current
      map.each_neighbour(current) do |node|
        if node == goal # we made it!
          node.parent = current
          node.mark_path
          return
        end
        next unless node.walkable?
        next if closed_set.include? node
        cost = current.cost + node.class.cost
        if open_set.include? node
          if cost < node.cost # but it's cheaper from current node!
            node.parent = current
            node.cost   = cost
          end
        else # we haven't seen this node
          open_set << node
          node.parent = current
          node.cost   = cost
          node.cost_estimated = node.position.distance(goal.position)
        end
      end
      # move "current" from open to closed set:
      closed_set << open_set.delete(current)
    end
    self.goal_nodes = nodes
  end

  def to_s
    @node_grid.collect{|row|
      row.collect{|node| node.to_s}.join('')
    }.join("\n")
  end
end

# see http://www.policyalmanac.org/games/aStarTutorial.htm
#abort "usage: #$0 <mapfile>" unless ARGV.size == 1
#path = Path.new(File.open(ARGV[0]))
#path.calculate
#puts path
#finder = PathFinder.new
#finder.find_path(map)
#puts map
