class Animal 
  include MongoMapper::Document

  key :x, Integer
  key :y, Integer
  key :species, String

  def find_path_to(other)
    path = Path.new(:start => self, :goal => other)
    path.calculate
    path.save
    path
  end

  def step
    case rand(4)
      when 0: self.x = x + 1;
      when 1: self.x = x - 1 unless x == 1;
      when 2: self.y = y + 1
      when 3: self.y = y - 1 unless y == 1;
      else
    end
  end
end
