require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'

RSpec.describe StatTracker do

  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      stat_tracker2 = StatTracker.new()
      expect(stat_tracker2).to be_an_instance_of(StatTracker)
    end

    it 'has attributes' do
      stat_tracker2 = StatTracker.new()
      expect(stat_tracker2.games).to be_a(Array)
      expect(stat_tracker2.teams).to be_a(Array)
      expect(stat_tracker2.game_teams).to be_a(Array)
      expect(stat_tracker2.games).to eq([])
      expect(stat_tracker2.teams).to eq([])
      expect(stat_tracker2.game_teams).to eq([])
    end
  end

  describe '::from_csv' do
    describe 'returns a StatTracker object' do
      it 'exists' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
      end

      it 'has correct attributes and classes' do
        expect(@stat_tracker.games).to be_a(Array)
        expect(@stat_tracker.teams).to be_a(Array)
        expect(@stat_tracker.game_teams).to be_a(Array)
        expect(@stat_tracker.games[0]).to be_a(Games)
        expect(@stat_tracker.teams[0]).to be_a(Teams)
        expect(@stat_tracker.game_teams[0]).to be_a(GameTeams)
      end
    end
  end

  #Game Statistics Methods

  describe '#highest_total_score' do
    it 'will find the highest sum of the team scores from all the games' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe '#count_of_games_by_season' do
    it 'will find total number of games by season' do

      expect(@stat_tracker.highest_total_score).to eq(10)
    end
  end
end
