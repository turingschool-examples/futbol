require './lib/stat_tracker'


RSpec.describe "Stat Tracker" do
  before(:each) do
      game_path       = './data/games.csv'
      team_path       = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                  }
      @stat_tracker = StatTracker.new(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a StatTracker
  end

  it "has attributes" do
    expect(@stat_tracker.games).to eq(game_path)
    expect(@stat_tracker.teams).to eq("#{\#<CSV::Table mode:col_or_row row_count:33>}")
    expect(@stat_tracker.game_teams).to eq('./data/game_teams.csv')

  end
end
