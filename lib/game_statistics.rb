class GameStatistics

  def initialize
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
    @csv_game_table = StatTracker.from_csv(locations)
    @instance_creation = StatTracker.new(locations)
  end

  def highest_total_score
    away_goals = @csv_game_table
      require "pry"; binding.pry
    
  end

end
