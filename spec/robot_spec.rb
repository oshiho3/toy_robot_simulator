describe "Robot" do

  before(:each) do
    @world = World.new
    @robot = Robot.new(@world)
  end

  it "scenario 1" do
    @robot.place(0,0,"north")
    @robot.move
    expect { @robot.report }.to output(/0,1,NORTH/).to_stdout
  end

  it "scenario 2" do
    @robot.place(0,0,"north")
    @robot.left
    expect { @robot.report }.to output(/0,0,WEST/).to_stdout
  end

  it "scenario 3" do
    @robot.place(1,2,"east")
    @robot.move
    @robot.move
    @robot.left
    @robot.move
    expect { @robot.report }.to output(/3,3,NORTH/).to_stdout
  end

  it "unplaced robot" do
    @robot.left
    @robot.right
    @robot.move
    expect { @robot.report }.to output(/Unplaced/).to_stdout
  end
end