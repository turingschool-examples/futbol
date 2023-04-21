require 'spec_helper'

RSpec.describe Futbol do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

    @futbol = Futbol.new(locations)
    @futbol.merge_game_game_teams
    require 'pry'; binding.pry
  end

  describe "#initialize" do
    it "exists" do
      expect(@futbol).to be_an_instance_of(Futbol)
      
    end
  end
end