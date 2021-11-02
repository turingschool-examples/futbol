require './lib/stat_tracker'


RSpec.describe "Stat Tracker" do
  it "exists" do
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }
    stat_tracker = StatTracker.new(locations)

    expect(stat_tracker).to be_a StatTracker
  end
end
