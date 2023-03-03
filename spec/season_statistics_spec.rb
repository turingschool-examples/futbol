require './spec/spec_helper'

RSpec.describe SeasonStatistics do
  before(:each) do
    games = './data/games.csv'
    teams = './data/teams.csv'
    game_teams = './data/game_teams.csv'
    @locations = {
      games: games,
      teams: teams,
      game_teams: game_teams
    }
    @season_stats = SeasonStatistics.new(@locations)
  end
  describe '#initialize' do
    it 'exists' do 
      expect(@season_stats).to be_a SeasonStatistics
      expect(@season_stats).to be_a Stats
    end

    it 'has teams' do
      expect(@season_stats.teams).to be_a Array 
      expect(@season_stats.teams.sample).to be_a Team
    end

    it 'has games' do
      expect(@season_stats.games).to be_a Array
      expect(@season_stats.games.sample).to be_a Game
    end

    it 'has game_teams' do
      expect(@season_stats.game_teams).to be_a Array
      expect(@season_stats.game_teams.sample).to be_a GameTeams
    end
  end
end