require 'spec_helper'

RSpec.describe TeamList do
  before(:each) do
    locations = {
      games: "./data/games_subset.csv",
      teams: "./data/teams_subset.csv",
      game_teams: "./data/game_teams_subset.csv"
    }
    stat_tracker = StatTracker.from_csv(locations)
    #passing in the instance not the class of stat tracker.
    @team_list = TeamList.new(locations[:teams], stat_tracker)
  end

  it 'exists' do
    expect(@team_list).to be_a(TeamList)

    expect(@team_list.teams).to be_a(Array)
    expect(@team_list.teams[0]).to be_a(Team)
  end

  it 'can create teams' do
    @team_list.create_teams("./data/teams_subset.csv")
    #this will break ousdie of dummy files
    # expect(@team_list.teams.count).to eq(20)
    expect(@team_list.teams).to all(be_an_instance_of Team)
  end
end
