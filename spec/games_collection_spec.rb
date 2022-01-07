require './lib/games_collection'
require './lib/stat_tracker'
require 'pry'

RSpec.describe GamesCollection do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path }


      @stat_tracker = StatTracker.from_csv(@locations)
  end
  it 'exists' do
    games = GamesCollection.new(@locations[:games])
    expect(games).to be_a(GamesCollection)
  end

  it 'can take a csv file from a stat tracker' do

    games = GamesCollection.new(@stat_tracker.locations[:games])
    expect(games.games_file).to eq('./data/games.csv')
  end

end
