require './lib/season_stats'
require './lib/stat_tracker'
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
    seasons_stats = SeasonStats.new()
    expect(seasons_stats).to be_a(SeasonStats)
  end
end
