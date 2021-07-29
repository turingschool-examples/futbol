require 'spec_helper'

RSpec.describe GameTeamManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_team_manager = GameTeamManager.new(locations)
  end

  it "exists" do
    expect(@game_team_manager).to be_a(GameTeamManager)
  end

  it "is an array" do
    expect(@game_team_manager.game_teams).to be_an(Array)
  end
end
