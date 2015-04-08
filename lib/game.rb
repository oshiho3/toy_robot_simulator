require_relative 'world'
require_relative 'robot'

class Game

  def initialize
    @world = World.new
    @robot = Robot.new(@world)
  end

  def execute_command(line)
    array = line.downcase.chomp.split(' ')
    if command = array[0]
      if array[1]
        options = array[1].split(',')
      end

      case command
      when "place", "move", "right", "left", "report"
        result, message = @robot.send(command.downcase, *options)
      when "exit"
        return false
      else
        puts "Invalid command."
      end

      puts message if message
      return true
    end
  end

  def get_prompt_string
    "Enter a command (PLACE, MOVE, LEFT, RIGHT or REPORT): "
  end
end