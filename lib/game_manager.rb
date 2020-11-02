require 'csv'
class GameManager
  attr_reader :games
  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    games_data = CSV.read(file_location, headers: true, header_converters: :symbol)
    @games = games_data.map do |game_data|
      Game.new(game_data)
    end
  end

  def highest_total_score
    most_goals = @games.max_by do |game|
      game.total_score
    end
    most_goals.total_score
  end

  def lowest_total_score
    least_goals = @games.min_by do |game|
      game.total_score
    end
    least_goals.total_score
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game.home_win?
    end
    (home_wins.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game.visitor_win?
    end
    (visitor_wins.to_f / @games.size).round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.tie?
    end
    (ties.to_f / @games.size).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new {|hash, key| hash[key] = 0}
    @games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    sum = @games.sum do |game|
      game.total_score
    end

    (sum.to_f / @games.size).round(2)
  end

  def games_by_season(season)
    @games.select do |game|
      season == game.season
    end
  end

  def game_ids_by_season(season)
    games_by_season(season).map do |game|
      game.id
    end
  end

  def goal_count(season)
    games_by_season(season).sum do |game|
      game.total_score
    end
  end

  def average_goals_by_season
    avg_by_season = Hash.new {|hash, key| hash[key] = 0}
    count_of_games_by_season.each do |season, games|
      avg = (goal_count(season).to_f / games).round(2)
      avg_by_season[season] += avg
    end
    avg_by_season
  end
  
  def games_by_team(id)
    @games.select do |game|
      game.away_team_id == id || game.home_team_id == id
    end
  end

  def team_games_by_season(id)
    team_by_season = Hash.new { |hash, key| hash[key] = [] }
    games_by_team(id).each do |game|
      team_by_season[game.season] << game
    end
    team_by_season
  end

  def team_games_by_opponent(id)
    games = Hash.new { |hash, key| hash[key] = [] }
    games_by_team(id).each do |game|
      games[game.away_team_id] << game if game.away_team_id != id
      games[game.home_team_id] << game if game.home_team_id != id
    end
    games
  end

  def team_season_stats(id)
    season_stats = Hash.new {|hash, key| hash[key] = Hash.new {|hash, key| hash[key] = 0}}
    team_games_by_season(id).each do |season, games|
      games.each do |game|
        season_stats[season][:game_count] += 1
        season_stats[season][:win_count] += 1 if game.win?(id)
      end
    end
    season_stats
  end

  def team_opponent_stats(id)
    opponent_stats = Hash.new {|hash, key| hash[key] = Hash.new {|hash, key| hash[key] = 0}}
    team_games_by_opponent(id).each do |opponent, games|
      games.each do |game|
        opponent_stats[opponent][:game_count] += 1
        opponent_stats[opponent][:win_count] += 1 if game.win?(id)
      end
    end
    opponent_stats
  end

  def percentage_wins_by_season(id)
    percentage_hash = Hash.new(0)
    team_season_stats(id).each do |season, stats|
      percentage_hash[season] = stats[:win_count].to_f / stats[:game_count]
    end
    percentage_hash
  end

  def percentage_wins_by_opponent(id)
    percentage_hash = Hash.new(0)
    team_opponent_stats(id).each do |opponent, stats|
      percentage_hash[opponent] = stats[:win_count].to_f / stats[:game_count]
    end
    percentage_hash
  end

  def best_season(id)
    percentage_wins_by_season(id).max_by do |season, percentage|
      percentage
    end.first
  end

  def worst_season(id)
    percentage_wins_by_season(id).min_by do |season, percentage|
      percentage
    end.first
  end

  def average_win_percentage(id)
    total_games = 0
    total_wins = 0
    team_season_stats(id).each do |season, stats|
      total_games += stats[:game_count]
      total_wins += stats[:win_count]
    end
    (total_wins.to_f / total_games).round(2)
  end

  def most_goals_scored(id)
    goals = 0
    games_by_team(id).each do |game|
      if game.away_team_id == id
        goals = game.away_goals if game.away_goals > goals
      else
        goals = game.home_goals if game.home_goals > goals
      end
    end
    goals
  end

  def fewest_goals_scored(id)
    goals = 9999
    games_by_team(id).each do |game|
      if game.away_team_id == id
        goals = game.away_goals if game.away_goals < goals
      else
        goals = game.home_goals if game.home_goals < goals
      end
    end
    goals
  end

  def favorite_opponent(id)
    percentage_wins_by_opponent(id).max_by do |opponent, percentage|
      percentage
    end.first
  end

  def rival(id)
    percentage_wins_by_opponent(id).min_by do |opponent, percentage|
      percentage
    end.first
  end
end
