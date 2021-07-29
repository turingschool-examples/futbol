require 'spec_helper'

RSpec.describe GameManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_manager = GameManager.new(locations)
  end

  it "exists" do
    expect(@game_manager).to be_a(GameManager)
  end

  it "is an array" do
    expect(@game_manager.games).to be_an(Array)
  end

  it "is an array of season numbers" do
    result = ["20122013", "20152016", "20132014", "20142015", "20172018", "20162017"]
    expect(@game_manager.array_of_seasons).to eq(result)
  end
end
