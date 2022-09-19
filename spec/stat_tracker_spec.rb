# require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  describe '#team_name' do
    it 'take in a team_id and returns the team name' do
      expect(@stat_tracker.team_name(6)).to eq('FC Dallas')
      expect(@stat_tracker.team_name(3)).to eq('Houston Dynamo')
    end
  end

end
