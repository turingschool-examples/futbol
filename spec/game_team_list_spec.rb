require 'spec_helper'

RSpec.describe GameTeamList do

  before(:each) do
    
    # full data: for when we go live
    # game_path = './data/games.csv'
    # game_teams_path = './data/game_teams.csv'
    # team_path = './data/teams.csv'
    
    # subset data: for faster testing purposes
    game_path = './data/games_subset.csv'
    team_path = './data/teams_subset.csv'
    game_team_path = './data/game_teams_subset.csv'

    # why did this finally work?? suddenly needed to make locations an instance throughout...
    # think about it, cause the answer is there, then ask Cyd if no one can deduce
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)

    @game_team_list = GameTeamList.new(@locations[:game_teams], @stat_tracker)
  end

  it 'can create a new GameTeamList class instance' do
    expect(@game_team_list).to be_a(GameTeamList)
    expect(@game_team_list.game_teams).to be_a(Array)
    expect(@game_team_list.game_teams[0]).to be_a(GameTeam)
  end

end