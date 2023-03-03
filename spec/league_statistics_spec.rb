require './spec/spec_helper'

RSpec.describe LeagueStatistics do
  before(:each) do
    games = './data/games.csv'
    teams = './data/teams.csv'
    game_teams = './data/game_teams.csv'
    @locations = {
      games: games,
      teams: teams,
      game_teams: game_teams
    }
    @league_stats = LeagueStatistics.new(@locations)
  end
  describe '#initialize' do
    it 'exists' do 
      expect(@league_stats).to be_a LeagueStatistics
      expect(@league_stats).to be_a Stats
    end

    it 'has teams' do
      expect(@league_stats.teams).to be_a Array 
      expect(@league_stats.teams.sample).to be_a Team
    end

    it 'has games' do
      expect(@league_stats.games).to be_a Array
      expect(@league_stats.games.sample).to be_a Game
    end

    it 'has game_teams' do
      expect(@league_stats.game_teams).to be_a Array
      expect(@league_stats.game_teams.sample).to be_a GameTeams
    end

    it 'can count teams' do
      expect(@league_stats.count_of_teams).to eq(32)
    end
  end
end