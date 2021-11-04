require 'csv'
require './lib/stat_tracker'
require './lib/game_team'
require './lib/game'
require './lib/team'
require './runner'


RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    @stat_tracker[0].read_game_stats(@game_path)
    @stat_tracker[0].read_team_stats(@team_path)
    @stat_tracker[0].read_game_teams_stats(@game_teams_path)
  end

  describe '#initialize' do
    it 'is an instance of StatTracker' do
      expect(@stat_tracker).to be_an_instance_of Array
    end

    it 'can read games.csv' do
      expect(@stat_tracker[0].games).to be_an_instance_of(Hash)
    end

    it 'can read teams.csv' do
      expect(@stat_tracker[0].teams).to be_an_instance_of(Hash)
    end

    it 'can read game_teams.csv' do
      expect(@stat_tracker[0].game_teams).to be_an_instance_of(Hash)
    end
  end

 #Leage Statistics Tests
  describe '#count_of_teams' do
    it 'returns total number of teams' do
      expect(@stat_tracker[0].count_of_teams).to eq(32)
    end

    it 'returns an integer' do
      expect(@stat_tracker[0].count_of_teams).to be_an_instance_of(Integer)
    end 
  end
end
