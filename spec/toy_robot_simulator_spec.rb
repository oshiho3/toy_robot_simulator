describe "Command" do

  before(:each) do
    @game = Game.new
  end

  it "Report: Unplaced" do
    expect(STDOUT).to receive(:puts).with("Unplaced")
    result = @game.execute_command("REPORT")
    expect(result).to eq(true)
  end

  it "Report: Placed" do
    game = Game.new

    result = @game.execute_command("PLACE 0,0,NORTH")
    expect(result).to eq(true)

    expect(STDOUT).to receive(:puts).with("0,0,NORTH")
    result = @game.execute_command("REPORT")
    expect(result).to eq(true)

    result = @game.execute_command("EXIT")
    expect(result).to eq(false)    
  end
end