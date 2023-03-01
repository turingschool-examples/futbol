require 'csv'
require 'rspec'
require './lib/games'

RSpec.describe Games do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @games = Games.new(locations)
  end

  describe 'games' do
    it 'exists with attributes' do
      expect(@games).to be_a(Games)
    end
  end
end