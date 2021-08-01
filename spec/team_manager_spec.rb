require 'spec_helper'

RSpec.describe TeamManager do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @team_manager = TeamManager.new(locations)
    @games = Game.read_file(locations[:games])

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

  it "can determine win percentage" do
    games = @games.find_all do |game|
      game.away_team_id == "3" || game.home_team_id == "3"
    end

    expect(@team_manager.win_percentage("3", games)).to eq(43.3)
  end

  it "can determine best season for a team" do
    expect(@team_manager.best_season("5")).to eq("20122013")
    expect(@team_manager.best_season("16")).to eq("20122013")
  end

  it "can determine the team's worst season" do
    expect(@team_manager.worst_season("3")).to eq("20132014")
    expect(@team_manager.worst_season("6")).to eq("20172018")
  end

  it "can average the win percentage" do
    expect(@team_manager.average_win_percentage("3")).to eq(43.3)
    expect(@team_manager.average_win_percentage("16")).to eq(44.2)
    
  end
end
