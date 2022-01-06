require 'RSpec'
require 'ostruct'
require './lib/team_manager'

RSpec.describe TeamManager do
  # before(:each) do
  #
  # end

  it "exists" do
    expect(@manager).to be_a(TeamManager)
  end

  it "reads CSV data and returns each row as a team object " do
    require "pry"; binding.pry
    expect(@manager.data).to include()
  end



end
