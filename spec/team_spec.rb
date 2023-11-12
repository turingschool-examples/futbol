require 'spec_helper'

RSpec.describe Team do

  before(:each) do
    
    # full data: for when we go live
    # game_path = './data/games.csv'
    # game_teams_path = './data/game_teams.csv'
    # team_path = './data/teams.csv'
    
    # subset data: for faster testing purposes
    game_path = './data/games_subset.csv'
    team_path = './data/teams_subset.csv'
    game_team_path = './data/game_teams_subset.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @team_list = TeamList.new(locations[:teams], @stat_tracker)
    @new_team = @team_list.create_teams(locations[:teams])
  end
  
  it 'exists' do
    expect(@new_team).to all(be_an_instance_of(Team))
  end

end