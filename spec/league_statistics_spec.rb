require "spec_helper"

RSpec.describe LeagueStatistics do
  before(:each) do 
    @teams_csv_file_path = ("./data/teams.csv")
    @game_teams_fixture_file_path = ("./fixture/game_teams_fixture.csv")
    @game_fixture_file_path = ("./fixture/game_fixture.csv")

  end

  it "can show total number of teams" do 
    league = LeagueStatistics.new(@teams_csv_file_path)

    expect(league.count_of_teams).to eq(32)
  end

  it "can show the name of the team with the highest average number of goals scored per game across all seasons " do 
    league = LeagueStatistics.new(@game_teams_fixture_file_path)

    expect(league.best_offense).to eq("FC Dallas")
  end
end