require_relative './game_collection'

class StatTracker
  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, teams_path, game_teams_path)
  end

  def initialize(game_path, teams_path, game_teams_path)
    @game_path = game_path
    @teams_path = teams_path
    @game_teams_path = game_teams_path
  end

  def game_repo
    GameCollection.new(@game_path)
  end

  def count_of_games_by_season
    games_per_season = Hash.new{0}
    game_repo.games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season.sort.to_h
  end

  def average_goals_per_game
    total_goals = game_repo.games.sum do |game|
      game.total_score
    end
    (total_goals.to_f/game_repo.total_games).round(2)
  end
end
