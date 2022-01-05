require './lib/team_statistics'
require 'RSpec'

RSpec.describe TeamStatistics do
  before(:each) do
    @team_stats = TeamStatistics.new()
  end

  it "exists" do
    expect(@team_stats).to be_a(TeamStatistics)
  end

end
