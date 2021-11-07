require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './runner'
require_relative 'stat_tracker_spec'

RSpec.describe StatTracker do
  before(:each) do
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

  describe '#instance of stat_tracker' do
    it 'exists' do
      expect(@stat_tracker).to be_instance_of(StatTracker)
    end
  end




# Game Statistics Test



# League Statistics Tests

  describe '#winningest_coach' do

    it 'returns a string' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("coach name")
    end
    #
    it 'gives name of Coach with best win percentage of season' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("coach name")
    end
  end

  describe '#worst_coach' do

    it 'returns a string' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("coach name")
    end

    it 'gives name of Coach with the worst win percentage for the season' do
      expect(@stat_tracker.worst_coach("20122013")).to eq("coach name")
    end
  end

  describe '#most_accurate_team' do
    it 'returns a string' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("team name")
    end

    it 'gives name of team with the best ratio of shots to goals for the season' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("team name")
    end
  end

  describe '#least_accurate_team' do
    it 'returns a string' do
      expect(@stat_tracker.least_accurate_team("20122013")).to be_a(String)
    end

    it 'gives name of team with the worst ratio of shots to goals for the season' do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq("team name")
    end
  end

  describe '#most_tackles' do
    it 'returns a string' do
      expect(@stat_tracker.most_tackles("20122013")).to be_a(String)
    end

    it 'gives name of team with the most tackles in the season' do
      expect(@stat_tracker.most_tackles("20122013")).to eq("team name")
    end
  end

  describe '#fewest_tackles' do
    it 'returns a string' do
      expect(@stat_tracker.fewest_tackles("20122013")).to be_a(String)
    end

    it 'gives name of team with the fewest tackles in the season' do
      expect(@stat_tracker.fewest_tackles("20122013")).to eq("team name")
    end
  end
end
# Season Statistics Tests


# Team Statistics Tests
