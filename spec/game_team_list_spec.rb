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

  it ' verify each instance' do
    expect(@game_team_list.game_teams[0].game_id).to eq("2012030221")
    expect(@game_team_list.game_teams[0].team_id).to eq("3")
    expect(@game_team_list.game_teams[0].hoa).to eq("away")
    expect(@game_team_list.game_teams[0].result).to eq("LOSS")
    expect(@game_team_list.game_teams[0].settled_in).to eq("OT")
    expect(@game_team_list.game_teams[0].head_coach).to eq("John Tortorella")
    expect(@game_team_list.game_teams[0].goals).to eq(2)
    expect(@game_team_list.game_teams[0].shots).to eq(8)
    expect(@game_team_list.game_teams[0].tackles).to eq(44)
    expect(@game_team_list.game_teams[0].pim).to eq(8)
    expect(@game_team_list.game_teams[0].powerplayopportunities).to eq(3)
    expect(@game_team_list.game_teams[0].powerplaygoals).to eq(0)
    expect(@game_team_list.game_teams[0].faceoffwinpercentage).to eq(44.8)
    expect(@game_team_list.game_teams[0].giveaways).to eq(17)
    expect(@game_team_list.game_teams[0].takeaways).to eq(7)
  end

end