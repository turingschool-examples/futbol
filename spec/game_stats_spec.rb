require 'spec_helper'

RSpec.describe GameStats do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_stats = GameStats.new(locations)
  end

  describe 'highest and lowest total scores' do
    it "#highest_total_score" do

      expect(@game_stats.highest_total_score).to eq(11)
    end
  
    it "#lowest_total_score" do
      expect(@game_stats.lowest_total_score).to eq(0)
    end
  end
end