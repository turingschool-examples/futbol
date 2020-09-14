require 'csv'

class GameManager
  attr_reader :games,
              :tracker
  def initialize(path, tracker)
    @games = []
    create_underscore_games(path)
    @tracker = tracker
  end

  def create_underscore_games(path)
    games_data = CSV.read(path, headers: true)
    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end

  def highest_total_score
    highest_score = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest_score.away_goals + highest_score.home_goals
  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest_score.away_goals + lowest_score.home_goals
  end

  def percentage_home_wins # game_manager.rb
    home_wins = @games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / games.length).round(2)
  end

  def percentage_ties
    tie_games = @games.count do |game|
      game.away_goals == game.home_goals
    end
    (tie_games.to_f / games.length).round(2)
  end

  def highest_scoring_visitor
    team_game_count = Hash.new(0)
    away_points = Hash.new(0)
    @games.each do |game|
      away_points[game.away_team_id] += game.away_goals
      team_game_count[game.away_team_id] += 1
    end
    highest_scoring_visitor = away_points.max_by do |team, score|
      score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(highest_scoring_visitor)
  end

  def highest_scoring_home_team
    team_game_count = Hash.new(0)
    home_points = Hash.new(0)
    @games.each do |game|
      home_points[game.home_team_id] += game.home_goals
      team_game_count[game.home_team_id] += 1
    end
    highest_scoring_home_team = home_points.max_by do |team, score|
      score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(highest_scoring_home_team)
  end

  def lowest_scoring_visitor
    team_game_count = Hash.new(0)
    away_points = Hash.new(0)
    @games.each do |game|
      away_points[game.away_team_id] += game.away_goals
      team_game_count[game.away_team_id] += 1
    end
    lowest_scoring_visitor = away_points.min_by do |team, score|
        score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(lowest_scoring_visitor)
  end
end
