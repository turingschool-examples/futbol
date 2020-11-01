require_relative './game'
require_relative './game_teams_collection'

class GamesCollection
  attr_reader :games

  def initialize(file_path, parent)
    @parent = parent
    @games = []
    create_games(file_path)
  end

  def create_games(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @games << Game.new(row)
    end
  end

  def find_season_id(id)
    game_ids = []
    games.find_all do |game|
      if game.season == id
        game_ids << game.game_id
      end
    end
    game_ids
  end

  def find_by_id(id)
    games.find do |game|
      if game.game_id == id
        return game.season
      end
    end
  end

  def highest_total_score
    highest = @games.max_by do |game|
      game.total_score
    end
    highest.total_score
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game.total_score
    end
    lowest.total_score
  end

  def percentage_home_wins
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    (visitor_wins.to_f / @games.length).round(2)
  end

  def percentage_ties
    (ties.to_f / @games.length).round(2)
  end

  def home_wins
    games.count do |game|
      game.home_goals > game.away_goals
    end
  end

  def visitor_wins
    games.count do |game|
      game.home_goals < game.away_goals
    end
  end

  def ties
    games.count do |game|
      game.home_goals == game.away_goals
    end
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    games.each do |game|
      seasons[game.season] += 1
    end
    seasons
  end

  def average_goals_per_game
    total_goals = games.sum do |game|
      game.total_score
    end
    (total_goals.to_f / games.count).round(2)
  end

  def average_goals_by_season
    seasons = Hash.new(0)
    games.each do |game|
      seasons[game.season] += game.total_score
    end
    count_of_games_by_season.merge(seasons) do |key, games_count, total_goals|
      (total_goals.to_f / games_count).round(2)
    end
  end

  def games_by_team(team_id)
    win = Hash.new {|h, k| h[k] = {wins: 0, total: 0}}
    @games.each do |game|
      if game.away_team_id == team_id && game.winner == "away"
        win[game.season][:wins] += 1
        win[game.season][:total] += 1
      elsif game.home_team_id == team_id && game.winner == "home"
        win[game.season][:wins] += 1
        win[game.season][:total] += 1
      elsif game.away_team_id == team_id || game.home_team_id == team_id
        win[game.season][:total] += 1
      end
    end
    win
  end

  def best_season(team_id)
    games_by_team(team_id).max_by do |season, numbers|
      numbers[:wins].to_f / numbers[:total]
    end.first
  end

  def worst_season(team_id)
    games_by_team(team_id).min_by do |season, numbers|
      numbers[:wins].to_f / numbers[:total]
    end.first
  end

  def average_win_percentage(team_id)
    wins = 0
    total = 0
    games_by_team(team_id).each do |season, values|
        wins += values[:wins]
        total += values[:total]
    end
    (wins / total.to_f).round(2)
  end

  def goals_scored_by_team(team_id)
    games_with_goals = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id
        games_with_goals[game.game_id] = game.away_goals
      elsif game.home_team_id == team_id
        games_with_goals[game.game_id] = game.home_goals
      end
    end
    games_with_goals
  end

  def most_goals_scored(team_id)
    goals_scored_by_team(team_id).max_by do |key, value|
      value
    end.last
  end

  def fewest_goals_scored(team_id)
    goals_scored_by_team(team_id).min_by do |key, value|
      value
    end.last
  end

  def games_against_opponents(team_id)
    wins = Hash.new {|h, k| h[k] = {wins: 0, total: 0}}
    @games.each do |game|
      if game.away_team_id == team_id && game.winner == "home"
        wins[game.home_team_id][:wins] += 1
        wins[game.home_team_id][:total] += 1
      elsif game.home_team_id == team_id && game.winner == "away"
        wins[game.away_team_id][:wins] += 1
        wins[game.away_team_id][:total] += 1
      elsif game.away_team_id == team_id && game.winner == "tied"
        wins[game.home_team_id][:total] += 1
      elsif game.home_team_id == team_id && game.winner == "tied"
        wins[game.away_team_id][:total] += 1
      elsif game.away_team_id == team_id && game.winner == "away"
        wins[game.home_team_id][:total] += 1
      elsif game.home_team_id == team_id && game.winner == "home"
        wins[game.away_team_id][:total] += 1
      end
    end
    wins
  end

  def favorite_opponent(team_id)
    opponent = games_against_opponents(team_id).min_by do |opp, numbers|
      numbers[:wins].to_f / numbers[:total]
    end
    @parent.find_by_id(opponent.first)
  end

  def rival(team_id)
    rival = games_against_opponents(team_id).max_by do |opp, numbers|
      numbers[:wins].to_f / numbers[:total]
    end
    @parent.find_by_id(rival.first)
  end
end
