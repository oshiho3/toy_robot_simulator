describe "World" do

  before(:each) do
    @world = World.new
  end

  context "valid?" do

    it "returns true - minimum" do
      result = @world.valid?(0,0)
      expect(result).to eq(true)
    end

    it "returns true - maximum" do
      result = @world.valid?(4,4)
      expect(result).to eq(true)
    end

    it "returns false > maximum" do
      result = @world.valid?(5,5)
      expect(result).to eq(false)
    end

    it "returns false < minimum" do
      result = @world.valid?(-1,-1)
      expect(result).to eq(false)
    end
  end

  context "range" do
    it "returns correct range" do
      minx, miny, maxx, maxy = @world.valid_range?
      expect(minx).to eq(0)
      expect(miny).to eq(0)
      expect(maxx).to eq(4)
      expect(maxy).to eq(4)
    end
  end
end