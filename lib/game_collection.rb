require "csv"
require_relative "./game"
require_relative "./divisable"

class GameCollection
  include Divisable
  attr_reader :game_path, :stat_tracker

  def initialize(game_path, stat_tracker)
    @game_path    = game_path
    @stat_tracker = stat_tracker
    @games        = []
    create_games(game_path)
  end

  def create_games(game_path)
    data = CSV.parse(File.read(game_path), headers: true)
    @games = data.map {|data| Game.new(data, self)}
  end

  # Season Statistics
  def scores_by_game
    @games.map {|game| game.away_goals.to_i + game.home_goals.to_i}.sort
  end

  def highest_total_score
    scores_by_game.last
  end

  def lowest_total_score
    scores_by_game.first
  end

  def count_of_games_by_season
    @games.each_with_object({}) do |game, games_per_season|
      (games_per_season[game.season] += 1 if games_per_season[game.season]) ||
      (games_per_season[game.season] = 1)
    end
  end

  def total_amount_games
    @games.count
  end

  def average_goals_per_game
    average(scores_by_game.sum, total_amount_games.to_f)
  end

  def sum_of_scores_by_season
    @games.each_with_object({}) do |game, scores_by_season|
      (scores_by_season[game.season] += game.away_goals.to_i + game.home_goals.to_i if scores_by_season[game.season]) ||
      (scores_by_season[game.season] = game.away_goals.to_i + game.home_goals.to_i)
    end
  end

  def season_id
    @games.map {|game| game.season}.uniq
  end

  def average_goals_by_season
    season_id.each_with_object({}) do |season, goals_per_season|
      goals_per_season[season] = average(sum_of_scores_by_season[season],
                                count_of_games_by_season[season].to_f)
    end
  end

  def game_ids_per_season
    @games.each_with_object({}) do |game, seasons_and_games|
      (seasons_and_games[game.season] << game.game_id if seasons_and_games[game.season]) ||
      (seasons_and_games[game.season] = [game.game_id])
    end
  end
  # League Statistic
  def total_goals_per_team_id_away
    @games.each_with_object(Hash.new(0)) do |game, sum_goals_away|
      (sum_goals_away[game.away_team_id] = game.away_goals.to_f if sum_goals_away[game.away_team_id].nil?) ||
      (sum_goals_away[game.away_team_id] += game.away_goals.to_f)
    end
  end

  def total_games_per_team_id_away
    @games.each_with_object({}) do |game, num_goals_away|
      num_goals_away[game.away_team_id] = @games.count do |gme|
        game.away_team_id == gme.away_team_id
      end
    end
  end

  def total_goals_per_team_id_home
    @games.each_with_object(Hash.new(0)) do |game, sum_goals_home|
      (sum_goals_home[game.home_team_id] = game.home_goals.to_f  if sum_goals_home[game.home_team_id].nil?) ||
      (sum_goals_home[game.home_team_id] += game.home_goals.to_f)
    end
  end

  def total_games_per_team_id_home
    @games.each_with_object({}) do |game, num_goals_home|
      num_goals_home[game.home_team_id] = @games.count do |gme|
        game.home_team_id == gme.home_team_id
      end
    end
  end
# Team Statistics
  def best_season(team_id)
    win_percentage = Hash.new {|hash_obj, key| hash_obj[key] = []}
    wins_by_season_per_team_id(team_id).each do |season, num_wins|
      total_games_by_season_per_team_id(team_id).each do |seazon, total|
        win_percentage[season] << average(num_wins, total) if season == seazon
      end
    end
    win_percentage.max_by {|season, pct| pct}[0]
  end

  def worst_season(team_id)
    loss_percentage = Hash.new {|hash_obj, key| hash_obj[key] = []}
    loss_by_season_per_team_id(team_id).each do |season, num_lost|
      total_games_by_season_per_team_id(team_id).each do |seazon, total|
      loss_percentage[season] << average(num_lost, total) if season == seazon
      end
    end
    loss_percentage.min_by {|season, pct| pct}[0]
  end
#Team Statistics Helpers
  def winning_games(team_id)
    @games.select do |game|
      (game.home_goals > game.away_goals && game.home_team_id == team_id) ||
      (game.away_goals > game.home_goals && game.away_team_id == team_id)
    end
  end

  def total_games_by_team_id(team_id)
    @games.select do |game|
     game.home_team_id == team_id || game.away_team_id == team_id
      end
  end

  def wins_by_season_per_team_id(team_id)
    winning_games(team_id).each_with_object(Hash.new(0)) do |win, wins_by_season|
      total = [win]
      wins_by_season[win.season] += total.count
    end
  end

  def total_games_by_season_per_team_id(team_id)
    total_games_by_team_id(team_id).each_with_object(Hash.new(0)) do |win, total_by_season|
      total = [win]
      total_by_season[win.season] += total.count
    end
  end

  def loss_by_season_per_team_id(team_id)
    losing_games(team_id).each_with_object(Hash.new(0)) do |loss, loss_by_season|
      total = [loss]
      loss_by_season[loss.season] += total.count
    end
  end

  def losing_games(team_id)
    @games.select do |game|
      (game.home_goals < game.away_goals && game.home_team_id == team_id) ||
      (game.away_goals < game.home_goals && game.away_team_id == team_id)
    end
  end
end
