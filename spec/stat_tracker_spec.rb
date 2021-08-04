require 'simplecov'
require './lib/stat_tracker'
require './lib/game_teams'
require './lib/game'
require './lib/team'


SimpleCov.start
RSpec.describe StatTracker do

  it 'exists' do
    stat_tracker = StatTracker.new([], [], [])

    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'can access instance variables' do
    stat_tracker = StatTracker.new(['a'], ['b'], ['c'])


    expect(stat_tracker.games).to eq(['a'])
    expect(stat_tracker.teams).to eq(['b'])
    expect(stat_tracker.game_teams).to eq(['c'])
  end

  it 'has arrays of objects' do
    game_path = './data/games.csv'

    team_path = './data/teams.csv'

    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.games.first).to be_a(Game)
    expect(stat_tracker.game_teams.first).to be_a(GameTeams)
    expect(stat_tracker.teams.first).to be_a(Team)
  end

  it 'can instatiate the right objects' do
    game_path = './data/games.csv'

    team_path = './data/teams.csv'

    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.game_statistics).to be_a(GameStatistics)
    expect(stat_tracker.season_statistics).to be_a(SeasonStatistics)
    expect(stat_tracker.league_statistics).to be_a(LeagueStatistics)
    expect(stat_tracker.team_statistics).to be_a(TeamStatistics)

  end
end
