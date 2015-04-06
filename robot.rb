class Robot

  FACING = [
    {id: 1, dir: "north", move: lambda{@y = @y-1 if @world.valid?(@x, @y-1)} },
    {id: 2, dir: "east", move: lambda{@x = @x+1 if @world.valid?(@x+1, @y)} },
    {id: 3, dir: "south", move: lambda{@y = @y+1 if @world.valid?(@x, @y+1)} },
    {id: 4, dir: "west", move: lambda{@x = @x-1 if @world.valid?(@x-1, @y)} },
  ]

  def initialize(world)
    @world = world
  end

  def place(x, y, direction)
    @x = x.to_i
    @y = y.to_i
    facing = FACING.select {|f| f[:dir] == direction.downcase}
    if facing.size > 0
      @facing_id = facing[0][:id]
    else
      puts "no such direction"
    end
    return true
  end

  def right
    @facing_id = @facing_id==FACING.size ? 1 : @facing_id + 1
    return true
  end

  def left
    @facing_id = @facing_id==1 ? FACING.size : @facing_id - 1
    return true
  end

  def move
    facing = FACING.select {|f| f[:id] == @facing_id}
    move_lambda = facing[0][:move]
    instance_exec(&move_lambda)
    return true
  end

  def report
    facing = FACING.select {|f| f[:id] == @facing_id}
    puts "#{@x},#{@y},#{facing[0][:dir]}"
    return true
  end

  def method_missing(method_sym, *arguments, &block)
    return false
  end
end