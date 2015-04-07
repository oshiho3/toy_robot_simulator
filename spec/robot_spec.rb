describe "Robot" do

  before(:each) do
    @world = World.new
    @robot = Robot.new(@world)
  end

  it "example a" do
    @robot.place(0,0,"north")
    @robot.move
    @robot.should_receive(:output).with("0,1,NORTH")
    @robot.report
  end

  it "example b" do
    @robot.place(0,0,"north")
    @robot.left
    @robot.should_receive(:output).with("0,0,WEST")
    @robot.report
  end

  it "example c" do
    @robot.place(1,2,"east")
    @robot.move
    @robot.move
    @robot.left
    @robot.move
    @robot.should_receive(:output).with("3,3,NORTH")
    @robot.report
  end

  context "place" do

    it "Wrong number of arguments" do
      result, message = @robot.place(10)
      expect(result).to eq(true)
      expect(message).to match(/Wrong number of arguments/)
    end

    it "Invalid position" do
      result, message = @robot.place(10,22,"east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid position/)
    end

    it "Invalid direction" do
      result, message = @robot.place(1,2,"north-east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid direction/)
    end
  end

  it "report for unplaced robot" do
    @robot.should_receive(:output).with("Unplaced")
    @robot.report
  end

end