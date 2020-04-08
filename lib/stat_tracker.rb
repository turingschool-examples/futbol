

class StatTracker

  # locations = {
  #   games: game_path,
  #   teams: team_path,
  #   game_teams: game_teams_path
  # }


  def self.from_csv(file_paths)
    team_path = file_paths[:teams]
    game_path = file_paths[:games]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(team_path, game_path, game_teams_path)
  end
    attr_reader :team_path, :game_path, :game_teams_path
  def initialize(team_path, game_path, game_teams_path)
    @team_path = team_path
    @game_path = game_path
    @game_teams_path = game_teams_path
  end

  def teams(file_path)
    Team.from_csv(team_path)
    Team.all_teams
  end

    def games(file_path)
      Game.from_csv(game_path)
      Game.all_games
  end

  def game_stats(file_path)
    GameStats.from_csv(file_path)
    game_stats = GameStats.all_game_stats

  end
end
