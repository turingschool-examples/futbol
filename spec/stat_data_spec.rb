require 'spec_helper'

RSpec.describe StatData do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_data = StatData.new(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_data).to be_a(StatData)
    end

    it 'reads CSV data' do
      expect(@stat_data.game_data).to be_a CSV::Table
      expect(@stat_data.team_data).to be_a CSV::Table
      expect(@stat_data.game_teams_data).to be_a CSV::Table
    end
  end

  describe '#all_games' do
    it 'makes an array of game objects' do
      expect(@stat_data.all_games).to be_an Array
      expect(@stat_data.all_games).to all(be_a Game)
      expect(@stat_data.all_games.count).to eq(7441)
    end
  end

  describe '#all_teams' do
    it 'makes an array of team objects' do
      expect(@stat_data.all_teams).to be_an Array
      expect(@stat_data.all_teams).to all(be_a Team)
      expect(@stat_data.all_teams.count).to eq(32)
    end

    it 'adds games to a teams games array' do
      expect(@stat_data.all_teams[0].games).to be_an Array
      expect(@stat_data.all_teams[0].games).to all(be_a Game)
      expect(@stat_data.all_teams[0].games.empty?).to be false
    end
  end

  describe '#all_game_teams' do
    it 'makes an array of game team objects' do
      expect(@stat_data.all_game_teams).to be_an Array
      expect(@stat_data.all_game_teams).to all(be_a GameTeam)
      expect(@stat_data.all_game_teams.count).to eq(14882)
    end
  end
end
