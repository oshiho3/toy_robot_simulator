class Robot

  def initialize(world)
    @world = world
  end

  def place(*arg)
    message = nil
    if 3 != arg.size
      return true, "Wrong number of arguments for PLACE command. (Valid example is'PLACE 1,2,NORTH')"
    end

    x = arg[0].to_i
    y = arg[1].to_i

    unless @world.valid?(x, y)
      minx, miny, maxx, maxy = @world.valid_range?
      return true, "Invalid position. Please enter the range x:#{minx}-#{maxx}, y:#{miny}-#{maxy}"
    end

    facing = FACING.find {|f| f[:dir] == arg[2]}
    unless facing
      return true, "Invalid direction. Please enter direction from #{FACING.map{|a| a[:dir].upcase}}"
    end
  
    @x = x
    @y = y
    @facing_id = facing[:id]
    return true, message
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
      output "#{@x},#{@y},#{facing[:dir].upcase}"
    else
      output "Unplaced"
    end
    return true
  end

  def facing
    FACING.find {|f| f[:id] == @facing_id}
  end

  private

  def output(str)
    puts str
  end

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