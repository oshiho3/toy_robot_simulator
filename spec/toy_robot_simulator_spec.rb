describe "Command" do

  before(:each) do
    @game = Game.new
  end

  context "PLACE command" do

    it "Report command: Unplace robot" do
      expect do
        result = @game.execute_command("REPORT")
        expect(result).to eq(true)
      end.to output(/Unplaced/).to_stdout
    end

    it "Place command: wrong number of arguments" do
      expect do
        result = @game.execute_command("PLACE 0,0")
        expect(result).to eq(true)
      end.to output(/Wrong number of arguments/).to_stdout

      # The robot shouldn't be placed after invalid command
      expect do
        result = @game.execute_command("REPORT")
        expect(result).to eq(true)
      end.to output(/Unplaced/).to_stdout
    end

    it "Place command: invalid x param" do
      expect do
        result = @game.execute_command("PLACE -1,0,NORTH")
        expect(result).to eq(true)
      end.to output(/Invalid position/).to_stdout

      # The robot shouldn't be placed after invalid command
      expect do
        result = @game.execute_command("REPORT")
        expect(result).to eq(true)
      end.to output(/Unplaced/).to_stdout
    end

    it "Place command: invalid y param" do
      expect do
        result = @game.execute_command("PLACE 0,5,NORTH")
        expect(result).to eq(true)
      end.to output(/Invalid position/).to_stdout

      # The robot shouldn't be placed after invalid command
      expect do
        result = @game.execute_command("REPORT")
        expect(result).to eq(true)
      end.to output(/Unplaced/).to_stdout
    end

    it "Place command: invalid direction" do
      expect do
        result = @game.execute_command("PLACE 1,4,NORTH-EAST")
        expect(result).to eq(true)
      end.to output(/Invalid direction/).to_stdout

      # The robot shouldn't be placed after invalid command
      expect do
        result = @game.execute_command("REPORT")
        expect(result).to eq(true)
      end.to output(/Unplaced/).to_stdout
    end

    it "Place command: valid" do
      expect do
        result = @game.execute_command("PLACE 1,4,NORTH")
        expect(result).to eq(true)
      end.to_not output.to_stdout

      # The robot should be placed
      expect do
        result = @game.execute_command("REPORT")
        expect(result).to eq(true)
      end.to output("1,4,NORTH\n").to_stdout
    end
  end

  it "Sequence of valid commands" do
    expect do
      result = @game.execute_command("PLACE 4,1,NORTH")
      expect(result).to eq(true)
    end.to_not output.to_stdout

    expect do
      result = @game.execute_command("REPORT")
      expect(result).to eq(true)
    end.to output("4,1,NORTH\n").to_stdout

    expect do
      result = @game.execute_command("MOVE")
      expect(result).to eq(true)
    end.to_not output.to_stdout

    expect do
      result = @game.execute_command("REPORT")
      expect(result).to eq(true)
    end.to output("4,2,NORTH\n").to_stdout

    expect do
      result = @game.execute_command("LEFT")
      expect(result).to eq(true)
    end.to_not output.to_stdout

    expect do
      result = @game.execute_command("REPORT")
      expect(result).to eq(true)
    end.to output("4,2,WEST\n").to_stdout

    expect do
      result = @game.execute_command("MOVE")
      expect(result).to eq(true)
    end.to_not output.to_stdout

    expect do
      result = @game.execute_command("REPORT")
      expect(result).to eq(true)
    end.to output("3,2,WEST\n").to_stdout

    expect do
      result = @game.execute_command("RIGHT")
      expect(result).to eq(true)
    end.to_not output.to_stdout

    expect do
      result = @game.execute_command("REPORT")
      expect(result).to eq(true)
    end.to output("3,2,NORTH\n").to_stdout

    result = @game.execute_command("EXIT")
    expect(result).to eq(false)
  end
end