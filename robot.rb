require 'pry'
class Robot

  def initialize(world)
    @world = world
  end

  def place(x, y, direction)
    x = x.to_i
    y = y.to_i
    facing = FACING.find {|f| f[:dir] == direction}
    if @world.valid?(x, y) && facing
      @x = x
      @y = y
      @facing_id = facing[:id]
    else
      puts "Invalid PLACE command format. (eg.'PLACE 1,2,NORTH')"
    end
    return true
  end

  def right
    @facing_id = (@facing_id==FACING.size) ? 1 : @facing_id + 1 if placed?
    return true
  end

  def left
    @facing_id = (@facing_id==1) ? FACING.size : @facing_id - 1 if placed?
    return true
  end

  def move
    instance_exec(&facing[:move]) if placed?
    return true
  end

  def report
    if placed?
      facing_temp = facing
      puts "#{@x},#{@y},#{facing[:dir].upcase}"
    else
      puts "Unplaced"
    end
    return true
  end

  def method_missing(method_sym, *arguments, &block)
    return false
  end

  def facing
    FACING.find {|f| f[:id] == @facing_id}
  end

  private

  def placed?
    defined? @x
  end

  FACING = [
    {id: 1, dir: "north", move: lambda{@y = @y+1 if @world.valid?(@x, @y+1)} },
    {id: 2, dir: "east", move: lambda{@x = @x+1 if @world.valid?(@x+1, @y)} },
    {id: 3, dir: "south", move: lambda{@y = @y-1 if @world.valid?(@x, @y-1)} },
    {id: 4, dir: "west", move: lambda{@x = @x-1 if @world.valid?(@x-1, @y)} },
  ]
end