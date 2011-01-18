require 'uta/commands'

describe UTA::Commands do
  describe ".[]" do
    it "should retrieve a constant with the given name" do
      obj = Object.new
      UTA::Commands::X = obj
      UTA::Commands[:x].should be(obj)
      UTA::Commands["x"].should be(obj)
      UTA::Commands[:X].should be(obj)
      UTA::Commands["X"].should be(obj)
    end
  end
end
