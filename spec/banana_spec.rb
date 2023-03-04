require './lib/banana'
require 'csv'
require 'rspec'

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

    @b = Banana.new(locations)
  end


  
  describe 'banana exists' do
    it 'exists' do
      expect(@b).to be_a(Banana)
    end
  end
end
