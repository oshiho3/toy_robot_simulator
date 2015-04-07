describe "Robot" do

  before(:each) do
    @world = World.new
    @robot = Robot.new(@world)
  end

  context "place" do

    it "Wrong number of arguments" do
      result, message = @robot.place(10)
      expect(result).to eq(true)
      expect(message).to match(/Wrong number of arguments/)
    end

    it "Invalid position > x-max" do
      result, message = @robot.place('5','0',"east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid position/)
    end

    it "Invalid position > y-max" do
      result, message = @robot.place('0','5',"east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid position/)
    end

    it "Invalid position < x-min" do
      result, message = @robot.place('-1','0',"east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid position/)
    end

    it "Invalid position < y-min" do
      result, message = @robot.place('0','-1',"east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid position/)
    end

    it "Valid position - minimum" do
      result, message = @robot.place('0','0',"east")
      expect(result).to eq(true)
      expect(message).to_not match(/Invalid position/)
    end

    it "Invalid position - maximum" do
      result, message = @robot.place('4','4',"east")
      expect(result).to eq(true)
      expect(message).to_not match(/Invalid position/)
    end

    it "Invalid direction" do
      result, message = @robot.place('1','2',"north-east")
      expect(result).to eq(true)
      expect(message).to match(/Invalid direction/)
    end
  end

  context "right" do
    it "changes from NORTH to EAST" do
      @robot.place('0','0',"north")
      @robot.right
      @robot.should_receive(:output).with(/EAST/)
      @robot.report
    end

    it "changes from EAST to SOUTH" do
      @robot.place('0','0',"east")
      @robot.right
      @robot.should_receive(:output).with(/SOUTH/)
      @robot.report
    end

    it "changes from SOUTH to WEST" do
      @robot.place('0','0',"south")
      @robot.right
      @robot.should_receive(:output).with(/WEST/)
      @robot.report
    end

    it "changes from WEST to NORTH" do
      @robot.place('0','0',"west")
      @robot.right
      @robot.should_receive(:output).with(/NORTH/)
      @robot.report
    end
  end

  context "left" do
    it "changes from NORTH to WEST" do
      @robot.place('0','0',"north")
      @robot.left
      @robot.should_receive(:output).with(/WEST/)
      @robot.report
    end

    it "changes from WEST to SOUTH" do
      @robot.place('0','0',"west")
      @robot.left
      @robot.should_receive(:output).with(/SOUTH/)
      @robot.report
    end

    it "changes from SOUTH to EAST" do
      @robot.place('0','0',"south")
      @robot.left
      @robot.should_receive(:output).with(/EAST/)
      @robot.report
    end

    it "changes from EAST to NORTH" do
      @robot.place('0','0',"east")
      @robot.left
      @robot.should_receive(:output).with(/NORTH/)
      @robot.report
    end
  end

  context "move" do
    it "ignore the move if it would fall off the edge" do
      @robot.place('0','0',"south")
      @robot.move
      @robot.should_receive(:output).with("0,0,SOUTH")
      @robot.report
    end

    it "moves if it would not fall off the edge" do
      @robot.place('0','0',"north")
      @robot.move
      @robot.should_receive(:output).with("0,1,NORTH")
      @robot.report
    end
  end

  it "report for unplaced robot" do
    @robot.should_receive(:output).with("Unplaced")
    @robot.report
  end

  context "seqences" do
    it "example a" do
      @robot.place('0','0',"north")
      @robot.move
      @robot.should_receive(:output).with("0,1,NORTH")
      @robot.report
    end

    it "example b" do
      @robot.place('0','0',"north")
      @robot.left
      @robot.should_receive(:output).with("0,0,WEST")
      @robot.report
    end

    it "example c" do
      @robot.place('1','2',"east")
      @robot.move
      @robot.move
      @robot.left
      @robot.move
      @robot.should_receive(:output).with("3,3,NORTH")
      @robot.report
    end
  end
end