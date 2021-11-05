class GameStats
  attr_reader :creator
  def initialize
    @creator =
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
  end

  def highest_total_score
    creator
    require "pry"; binding.pry
  end

  def lowest_total_score
  end
end