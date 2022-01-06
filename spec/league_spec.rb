require './lib/league_tracker'
require 'csv'
require './lib/game'
require './lib/team_tracker'

RSpec.describe do LeagueTracker
  it 'exists' do
    game_path = './data/games_stub.csv'
    team_tracker = LeagueTracker.new(game_path)
    expect(team_tracker).to be_a(LeagueTracker)
  end

  it 'can count teams' do
    game_path = './data/games_stub.csv'
    team_tracker = LeagueTracker.new(game_path)
    expect(team_tracker.count_of_teams).to eq(32)
  end

  it 'can tell best offense' do
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
