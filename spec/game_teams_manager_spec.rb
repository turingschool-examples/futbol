require 'CSV'
require './lib/stat_tracker'
require './lib/game_teams_manager'


RSpec.describe GameTeamsManager do
  it 'exists' do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)

    expect(game_teams_manager).to be_an_instance_of(GameTeamsManager)
  end

  it 'can create game objects' do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)

    expect(game_teams_manager.game_teams_objects[0]).to be_an(GameTeams)

    expect(game_teams_manager.game_teams_objects.count).to eq(14882)

  end
end
