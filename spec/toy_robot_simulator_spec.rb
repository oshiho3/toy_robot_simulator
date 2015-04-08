require 'toy_robot_simulator_spec_helper'

describe "Command" do

  it "accept command line" do

    local_io("exit") {
      STDOUT.should_receive(:puts).with("exit")
    }
  end
end