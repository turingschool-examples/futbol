require 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/s_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/s_team_game.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new(locations)
  end

  describe '.from_csv and #initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_a StatTracker
    end

    it 'reads CSV data' do
      expect(@stat_tracker.game_data).to be_a CSV::Table
      expect(@stat_tracker.team_data).to be_a CSV::Table
      expect(@stat_tracker.game_teams_data).to be_a CSV::Table
    end
  end

  describe '#all_games' do
    it 'makes an array of game objects' do
      expect(@stat_tracker.all_games).to be_an Array
      expect(@stat_tracker.all_games).to all(be_a Game)
      expect(@stat_tracker.all_games.count).to eq(58)
    end
  end

  describe '#all_teams' do
    it 'makes an array of team objects' do
      expect(@stat_tracker.all_teams).to be_an Array
      expect(@stat_tracker.all_teams).to all(be_a Team)
      expect(@stat_tracker.all_teams.count).to eq(32)
    end

    it 'adds games to a teams games array' do
      expect(@stat_tracker.all_teams[0].games).to be_an Array
      expect(@stat_tracker.all_teams[0].games).to all(be_a Game)
      expect(@stat_tracker.all_teams[0].games.empty?).to be false
    end
  end

  describe '#all_game_teams' do
    it 'makes an array of game team objects' do
      expect(@stat_tracker.all_game_teams).to be_an Array
      expect(@stat_tracker.all_game_teams).to all(be_a GameTeam)
      expect(@stat_tracker.all_game_teams.count).to eq(48)
    end
  end

  describe '#games_by_season' do
    it 'games by season' do
      expect(@stat_tracker.games_by_season).to be_a(Hash)
      require 'pry'; binding.pry
    end
  end
end
