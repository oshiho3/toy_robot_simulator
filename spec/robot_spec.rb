describe "Robot" do

  before(:each) do
    @world = World.new
    @robot = Robot.new(@world)
  end

  it "scenario 1" do
    @robot.place(0,0,"NORTH")
    @robot.move
    expect { @robot.report }.to output(/0,1,NORTH/).to_stdout
  end

  it "scenario 2" do
    @robot.place(0,0,"NORTH")
    @robot.left
    expect { @robot.report }.to output(/0,0,WEST/).to_stdout
  end

  it "scenario 3" do
    @robot.place(1,2,"EAST")
    @robot.move
    @robot.move
    @robot.left
    @robot.move
    expect { @robot.report }.to output(/3,3,NORTH/).to_stdout
  end

end