require './lib/game_stats'
require 'csv'

RSpec.describe GameStats do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    @game_stats = GameStats.new(@locations)
    end

    it 'exists' do
      expect(@game_stats).to be_an_instance_of(GameStats)
    end

    it 'has locations D:' do
      expect(@game_stats.game_path).to eq(@locations[:games])
      expect(@game_stats.team_path).to eq(@locations[:teams])
      expect(@game_stats.game_teams_path).to eq(@locations[:game_teams])
    end

    xit 'highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end
end
