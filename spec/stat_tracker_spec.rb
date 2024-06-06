require 'rspec'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require 'csv'

RSpec.describe StatTracker do
  before(:all) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end

  describe '.from_csv' do
    it 'exists' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker).to be_instance_of(StatTracker)
    end

    it 'loads games' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker.games).to all(be_a(Game))
      expect(stat_tracker.games.size).to eq(CSV.read(@game_path, headers: true).size)
    end

    it 'loads teams' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker.teams).to all(be_a(Team))
      expect(stat_tracker.teams.size).to eq(CSV.read(@team_path, headers: true).size)
    end

    it 'loads game_teams' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker.game_teams).to all(be_a(GameTeam))
      expect(stat_tracker.game_teams.size).to eq(CSV.read(@game_teams_path, headers: true).size)
    end
  end
end
