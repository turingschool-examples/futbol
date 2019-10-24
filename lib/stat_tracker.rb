require_relative './game_collection'

class StatTracker
  attr_reader :game_repo

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, teams_path, game_teams_path)
  end

  def initialize(game_path, teams_path, game_teams_path)
    @teams_path = teams_path
    @game_teams_path = game_teams_path
    @game_repo = GameCollection.new(game_path)
  end

  def count_of_games_by_season
    games_per_season = Hash.new{0}
    @game_repo.games.each { |game| games_per_season[game.season] += 1 }
    games_per_season.sort.to_h
  end

  def average_goals_per_game
    total_goals = @game_repo.games.sum { |game| game.total_score }
    (total_goals.to_f/@game_repo.total_games).round(2)
  end

  def highest_total_score
    @game_repo.games.max_by {|game| game.total_score}.total_score
  end

  def lowest_total_score
    @game_repo.games.min_by {|game| game.total_score}.total_score
  end

  def biggest_blowout
    @game_repo.games.max_by {|game| game.game_goal_difference}.game_goal_difference
  end

  def percentage_home_wins
    (@game_repo.games.count {|game| game.home_team_win?}.to_f / @game_repo.total_games).round(2)
  end

  def percentage_visitor_wins
    (@game_repo.games.count {|game| game.visitor_team_win?}.to_f / @game_repo.total_games).round(2)
  end

  def percentage_ties
    (@game_repo.games.count {|game| game.tie_game?}.to_f / @game_repo.total_games).round(2)

  end

end
