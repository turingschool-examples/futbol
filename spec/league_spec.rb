require './lib/game_team'
require 'csv'
require './lib/game'
require './lib/game_team_tracker'

RSpec.describe do GameTeam
  it 'exists' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game_team = GameTeam.new(locations)
    expect(game_tracker).to be_a(GameTracker)
  end

  xit 'can count teams' do
    game_path = './data/games_stub.csv'
    team_tracker = LeagueTracker.new(game_path)
    expect(team_tracker.count_of_teams).to eq(32)
  end

  xit 'can tell best offense' do
    game_path = './data/games_stub.csv'
    team_tracker = LeagueTracker.new(game_path)
    expect(team_tracker.best_offense).to eq("FC Dallas")
  end

  # it '' do
  # end
  #
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end

end
