require 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path       = './data/dummy_game.csv'
    team_path       = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists & has attributes' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end
end