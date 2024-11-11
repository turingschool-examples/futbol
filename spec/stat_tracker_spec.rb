require_relative 'spec_helper'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  describe '#initialize' do
    it 'exists' do
      stat_tracker = StatTracker.new(@locations)
      expect(stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'has attributes' do
      stat_tracker = StatTracker.new(@locations)
      expect(stat_tracker.game_path).to eq('./data/games.csv')
      expect(stat_tracker.team_path).to eq('./data/teams.csv')
      expect(stat_tracker.game_teams_path).to eq('./data/game_teams.csv')
      expect(stat_tracker.games).to eq(Games)
      expect(stat_tracker.teams).to eq(Teams)
      expect(stat_tracker.game_teams).to eq(GameTeams)
    end
  end

  describe '#from_csv' do
    it 'exists' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'has attributes' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker.game_path).to eq('./data/games.csv')
      expect(stat_tracker.team_path).to eq('./data/teams.csv')
      expect(stat_tracker.game_teams_path).to eq('./data/game_teams.csv')
    end
  end

  describe '#create_databases' do
    it 'asks classes to create themselves' do
      stat_tracker = StatTracker.from_csv(@locations)
      expect(stat_tracker.game_teams.all[0]).to be_an_instance_of(GameTeams)
      expect(stat_tracker.teams.all[0]).to be_an_instance_of(Teams)
      expect(stat_tracker.games.all[0]).to be_an_instance_of(Games)
      expect(stat_tracker.game_teams.all[0].result).to eq("LOSS")
      expect(stat_tracker.teams.all[0].team_name).to eq("Atlanta United")
      expect(stat_tracker.games.all[0].season).to eq("20122013")
    end
  end
end