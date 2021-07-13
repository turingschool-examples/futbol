require './lib/stat_tracker'

class Runner
  def initialize
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def locations
    {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end
end
