class World
  def initialize
    @width = 5
    @height = 5
  end

  def valid?(x, y)
    return true if x>=0 && x<@width && y>=0 && y<@height
    return false
  end
end