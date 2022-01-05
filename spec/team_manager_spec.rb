require 'RSpec'
require './lib/team_manager'

RSpec.describe TeamManager do
  before(:each) do
    @manager = TeamManager.new("./data/teams.csv")
  end

  it "exists" do
    expect(@manager).to be_a(TeamManager)
  end

end
