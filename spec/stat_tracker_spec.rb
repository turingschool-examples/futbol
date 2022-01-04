require './lib/stat_tracker'
require 'pry'
require 'simplecov'
# SimpleCov.start

RSpec.describe  StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new("places")
    # binding.pry
    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'from CSV create new StatTracker' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker).to be_a(StatTracker)
  end

end
