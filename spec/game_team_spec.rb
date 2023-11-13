require 'spec_helper'

RSpec.describe GameTeam do

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
    @game_team_list = GameTeamList.new(locations[:game_teams], @stat_tracker)
    @new_game_team = @game_team_list.create_game_teams(locations[:game_teams])
  end
  
  it 'exists' do
    expect(@new_game_team).to all(be_an_instance_of(GameTeam))
  end

end