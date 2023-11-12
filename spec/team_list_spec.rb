require 'spec_helper'

RSpec.describe TeamList do

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

    @team_list = TeamList.new(@locations[:teams], @stat_tracker)
  end

  it 'can create a new TeamList class instance' do
    expect(@team_list).to be_a(TeamList)
    expect(@team_list.teams).to be_a(Array)
    expect(@team_list.teams[0]).to be_a(Team)
  end

    # Steve needs to write his damn methods, the two below specifically
  xit 'can return the highest scoring visitor team' do
    expect(@team_list.highest_scoring_visitor).to eq("FC Dallas")
  end
  
  xit 'can return the highest scoring home team' do
    expect(@team_list.highest_scoring_home_team).to eq("New York City FC")
  end

end
