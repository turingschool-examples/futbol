require './lib/games_teams_collection'
require './lib/stat_tracker'
require 'pry'

RSpec.describe GamesTeamsCollection do
  before(:each) do
    game_teams_path = './data/game_teams.csv'
    game_path = './data/games.csv'
    team_path = './data/teams.csv'

    locations = {games: game_path, teams: team_path, game_teams: game_teams_path}
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
      game_teams = GamesTeamsCollection.new(@stat_tracker.locations[:game_teams])
    expect(game_teams).to be_a(GamesTeamsCollection)
  end
end
