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

  describe '.from_csv' do
    it 'exists' do
      expect(@stat_tracker).to be_a StatTracker
    end
  end
end
