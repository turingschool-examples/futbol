require 'spec_helper'

RSpec.describe SeasonManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

    @stat_tracker = StatTracker.from_csv(locations)
    @season_manager = @stat_tracker.season_manager
  end

  it 'exists' do
    expect(@season_manager).to be_a(SeasonManager)
  end
end
