require "spec_helper"

RSpec.describe GameStatistics do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_stats = GameStatistics.new(locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@game_stats).to be_a(GameStatistics)
    end
  end

  describe "#percentage home wins" do
    xit "calculates percentage of home wins and returns float" do

    end
  end
end