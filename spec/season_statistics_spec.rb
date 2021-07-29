require './lib/stat_tracker'
require './lib/season_statistics'
require 'simplecov'
require 'CSV'

SimpleCov.start
RSpec.describe SeasonStatistics do
  before :each do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @season_stats = SeasonStatistics.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end

  it 'exists & has attributes' do
    expect(@season_stats).to be_a(SeasonStatistics)
    expect(@season_stats.games).to be_a(Array)
    expect(@season_stats.teams).to be_a(Array)
    expect(@season_stats.game_teams).to be_a(Array)
  end

  it 'returns total games by coach' do
    expect(@season_stats.total_games_by_coach("20122013")).to eq({
     "Claude Julien"    => 9,
     "Dan Bylsma"       => 4,
     "Darryl Sutter"    => 4,
     "Joel Quenneville" => 12,
     "John Tortorella"  => 5,
     "Ken Hitchcock"    => 4,
     "Michel Therrien"  => 5,
     "Mike Babcock"     => 7,
     "Mike Yeo"         => 5,
     "Paul MacLean"     => 5
    })
  end

  it 'winningest coach' do
    expect(@season_stats.winningest_coach("20122013")).to eq("Claude Julien")
  end

  it 'worst coach' do
    expect(@season_stats.worst_coach("20122013")).to eq("John Tortorella")
  end

  it 'returns a hash with team ID keys and team name values' do
    expect(@season_stats.team_identifier("3")).to eq("Houston Dynamo")
  end

  it "counts total shots" do
    expect(@season_stats.total_shots('20122013')).to eq({
      "16" => 99,
      "17" => 46,
      "19" => 28,
      "26" => 26,
      "3"  => 38,
      "30" => 33,
      "5"  => 32,
      "6"  => 76,
      "8"  => 43,
      "9"  => 36
      })
  end

  it "most accurate team" do
    expect(@season_stats.most_accurate_team('20122013')).to eq("New York City FC")
  end

  it "least accurate team" do
    expect(@season_stats.least_accurate_team('20122013')).to eq("Sporting Kansas City")
  end
end
