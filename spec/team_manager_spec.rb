require 'spec_helper'

RSpec.describe TeamManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @team_manager = TeamManager.new(locations)
  end

  it "exists" do
    expect(@team_manager).to be_a(TeamManager)
  end

  it "is an array" do
    expect(@team_manager.teams).to be_an(Array)
  end

  it 'can return a single team by id' do
    expect(@team_manager.team_by_id("1")).to be_a(Team)
  end

  it "can determine team info" do
    expected = {
      team_id: "1",
      franchise_id: "23",
      team_name: "Atlanta United",
      abbreviation: "ATL",
      link: "/api/v1/teams/1"
    }
    expect(@team_manager.team_info("1")).to eq(expected)
  end

end
