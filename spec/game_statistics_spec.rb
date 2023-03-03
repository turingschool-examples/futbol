require './spec/spec_helper'

RSpec.describe GameStatistics do
  before(:each) do
    games = './data/mock_games.csv'
    teams = './data/teams.csv'
    game_teams = './data/mock_game_teams.csv'
    @locations = {
      games: games,
      teams: teams,
      game_teams: game_teams
    }
    @game_stats = GameStatistics.new(@locations)
  end
  describe '#initialize' do
    it 'exists' do 
      expect(@game_stats).to be_a GameStatistics
      expect(@game_stats).to be_a Stats
    end

    it 'has teams' do
      expect(@game_stats.teams).to be_a Array 
      expect(@game_stats.teams.sample).to be_a Team
    end

    it 'has games' do
      expect(@game_stats.games).to be_a Array
      expect(@game_stats.games.sample).to be_a Game
    end

    it 'has game_teams' do
      expect(@game_stats.game_teams).to be_a Array
      expect(@game_stats.game_teams.sample).to be_a GameTeams
    end
  end

  describe '#percentage_home_wins' do
    it 'returns the percentage of home team wins' do
      expect(@game_stats.percentage_home_wins).to eq(55.56)
      expect(@game_stats.percentage_home_wins).to be_a Float
    end
  end

  describe '#percentage_visitor_wins' do
  it 'returns the percentage of home team wins' do
    expect(@game_stats.percentage_visitor_wins).to eq(44.44)
    expect(@game_stats.percentage_visitor_wins).to be_a Float
  end
end
end