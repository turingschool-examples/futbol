require "simplecov"
require "CSV"
require "./lib/stat_tracker"
require "./lib/league_statistics"


SimpleCov.start
RSpec.describe League do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    # @league = League.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end

  xit 'exists and can read data' do
    league = League.new([], [], [])

    expect(league).to be_a(League)
    expect(league.games).to eq([])
    expect(league.teams).to eq([])
    expect(league.game_teams).to eq([])
  end

  it 'can count numbers of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it 'can get best offense' do
    expect(@stat_tracker.best_offense).to eq("New York City FC")
  end

  it 'can get an array of games played' do
    expect(@stat_tracker.games_by_team(3)).to be_a(Array)
    expect(@stat_tracker.games_by_team(3).length).to eq(17)
  end

  it 'can make an average from games' do
    expect(@stat_tracker.games_average(3)).to eq(1.5294117647058822)
  end

  it 'can get worst offense' do
    expect(@stat_tracker.worst_offense).to eq("Chicago Fire")
  end

  it 'can get highest scoring visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'can filter away games' do
    expect(@stat_tracker.away_games(3).length).to eq(10)
  end

  it 'can average away games' do
    expect(@stat_tracker.away_average(3)).to eq(1.7)
  end

  it 'can filter home games' do
    expect(@stat_tracker.home_games(3).length).to eq(7)
  end

  it 'can get highest scoring home team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq("New York City FC")
  end

  it 'can get lowest scoring away team' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Seattle Sounders FC")
  end

  it 'can get lowest scoring home team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Chicago Fire")
  end

  it 'can get home average' do
    expect(@stat_tracker.home_average(3)).to eq(1.2857142857142858)
  end

end
