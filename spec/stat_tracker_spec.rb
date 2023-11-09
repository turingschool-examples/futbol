require 'spec_helper'

RSpec.describe StatTracker do

  before(:each) do
    # full data 
    # game_path = './data/games.csv'
    # team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams.csv'
    
    # subset data
    game_path = './data/games_subset.csv'
    team_path = './data/teams_subset.csv'
    game_teams_path = './data/game_teams_subset.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end
  
end