require './spec/spec_helper'

RSpec.describe GameStatistics do
  before(:each) do
    games = './data/games.csv'
    teams = './data/teams.csv'
    game_teams = './data/game_teams.csv'
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
    it 'returns percentage of home team wins' do
      mock_game = instance_double(Game, {away_goals: 4, home_goals: 3})
      mock_game_2 = instance_double(Game, {away_goals: 2, home_goals: 3})
      mock_game_3 = instance_double(Game, {away_goals: 1, home_goals: 1})
      mock_game_4 = instance_double(Game, {away_goals: 4, home_goals: 5})
      games_array = [mock_game, mock_game_2, mock_game_3, mock_game_4]

      allow(@game_stats).to receive(:games).with(array_including(games_array))
      
      expect(@game_stats.percentage_home_wins).to eq(50.00)
      expect(@game_stats.percentage_home_wins).to be_a Float
    end
  end

end