
require 'simplecov'
SimpleCov.start
require './lib/game_team'
require 'csv'
require './lib/game'
require './lib/game_team_tracker'

RSpec.describe do GameTeamTracker
  it 'exists' do
    game_path = './data/game_teams_stub.csv'
    locations = {
      games: './data/games_stub.csv',
      game_teams: game_path}
    game_tracker = GameTeamTracker.new(locations)
    expect(game_tracker).to be_a(GameTeamTracker)
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
