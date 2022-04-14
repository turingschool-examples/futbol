require './lib/team_stats'
require './lib/game_teams'
require './modules/league_statistics'
require './lib/stat_tracker'
require 'rspec'

describe LeagueStats do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '#count of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "#best offense"do
  expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

end
