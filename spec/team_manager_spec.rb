require 'CSV'
require './lib/stat_tracker'
require './lib/team_manager'

RSpec.describe TeamManager do
  it 'exists' do
    team_path = './data/teams.csv'
    team_manager = TeamManager.new(team_path)

    expect(team_manager).to be_an_instance_of(TeamManager)
  end

  it 'can create team objects' do
    team_path = './data/teams.csv'
    team_manager = TeamManager.new(team_path)

    expect(team_manager.team_objects[0]).to be_an(Teams)
    # expect(game_manager.add_objects).to be_an_instance_of(GameManager)
    # expect(team_manager.highest_total_score).to eq(0)
  end

  it 'counts the number of teams' do
    team_path = './data/teams.csv'
    team_manager = TeamManager.new(team_path)

    expect(team_manager.count_of_teams).to eq(32)
  end
end
