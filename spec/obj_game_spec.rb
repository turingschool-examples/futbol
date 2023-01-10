require 'csv'
require 'spec_helper.rb'

RSpec.describe Game do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  let(:game) { Game.new(locations) }
  
  describe "#initialize" do
    it "exists" do
    expect(game.game_id).to be_a(Integer)
    end 
  end
end