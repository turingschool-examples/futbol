require 'spec_helper'

RSpec.describe StatTracker do
  context 'initialize' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it "exists" do
      expect(stat_tracker).to be_a(StatTracker)
    end
  end
