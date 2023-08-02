require "spec_helper"

RSpec.describe LeagueStatistics do
  before(:each) do 
    @game_teams_fixture_file_path = ("./fixture/game_teams_fixture.csv")
  end

  it "can show total number of teams" do 
    league = LeagueStatistics.new(@game_teams_fixture_file_path)

    expect(league.count_of_teams).to eq(19)
  end
end