require 'csv'
require_relative 'game'
require_relative 'collection'

class GameCollection < Collection
  attr_reader :games_list

  def initialize(file_path)
    @games_list = create_objects(file_path, Game)
  end

  def all_games(id)
    number_id = id.to_i
    @games_list.find_all{|game|(game.home_team_id == id) || (game.away_team_id == number_id)}
  end

  def all_games_by_season(id)
    all_games(id).group_by {|game| game.season}
  end

  def total_games_per_season(id)
    all_games_by_season(id).reduce({}) do |total, (season, games)|
      total[season] = games.length
      total
    end
  end

  def wins_in_season(id)
    number_id = id.to_i
    all_games_by_season(id).reduce(Hash.new(0)) do |season_wins, (season, games)|
      wins = games.count do |game|
        (game.home_team_id == number_id && game.home_team_win?)||(game.away_team_id == number_id && game.visitor_team_win?)
      end
        season_wins[season] += wins
        season_wins
    end
  end
#h1.merge(h2) {|key, oldval, newval| newval - oldval}
  def win_percentage(id)
    number_id = id.to_i
    wins = wins_in_season(number_id)
    total = total_games_per_season(number_id)
    wins.merge(total) {|season, wins, games|(wins.to_f/games).round(2) * 100}
  end

  def best_season(id)
    number_id = id.to_i
    win_percentage(number_id).max_by do |season, percentage|
      percentage
    end.first
  end

  def worst_season(id)
    win_percentage(id).min_by do |season, percentage|
      percentage
    end.first
  end

  def opponent_stats(id)
    number_id = id.to_i
    total_games = all_games(number_id)
    opponent_hash = Hash.new{|id, games| id[games] = []}
    total_games.each do |game|
      opponent_hash[game.home_team_id] << game
      opponent_hash[game.away_team_id] << game
      opponent_hash.delete(id)
    end
    opponent_hash
  end

  def opponent_total_games_played(id)
    number_id = id.to_i
    opponent_stats(number_id).reduce({}) do |total, (id, games)|
    total[id] = games.length
    total
    end
  end

  def opponent_wins(id)
    number_id = id.to_i
    opponent_stats(number_id).reduce(Hash.new(0)) do |opponent_wins, (id, games)|
      wins = games.count do |game|
        (game.home_team_id == id && game.home_team_win?)||(game.away_team_id == id && game.visitor_team_win?)
      end
      opponent_wins[id] += wins
      opponent_wins
    end
  end

  def opponent_win_percentage(id)
    number_id = id.to_i
    wins = opponent_wins(number_id)
    total = opponent_total_games_played(number_id)
    wins.merge(total) {|id, wins, games|(wins.to_f/games).round(2) * 100}
  end

  def favorite_opponent_id(id)
    number_id = id.to_i
    opponent_win_percentage(number_id).min_by do |id, percentage|
      percentage
    end.first
  end

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def percentage_home_wins
    percentage(home_wins.to_f / @games_list.length.to_f)
  end

  def percentage_visitor_wins
    percentage(away_wins.to_f / @games_list.length.to_f)
  end

  def percentage_ties
    percentage(ties.to_f / @games_list.length.to_f)
  end

  def count_of_games_by_season
    @games_list.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    # (total_scores.sum.to_f / @games_list.length.to_f).round(2)
    average2(total_scores, games_list)
  end

  def average_goals_by_season
    games_per_season = count_of_games_by_season
    goals_per_season = {}

    games_per_season.each do |season|
      @games_list.each do |game|
        if game.season == season[0] && goals_per_season[season[0]] != nil
          goals_per_season[season[0]] += game.away_goals + game.home_goals
        elsif game.season == season[0]
          goals_per_season[season[0]] = game.away_goals + game.home_goals
        end
      end
    end

    results = {}
    goals_per_season.each do |season|
      results[season[0]] = (season[1].to_f / games_per_season[season[0]]).round(2)
    end
    results
  end

  # helper methods

  def percentage(collection)
    (collection).round(2)
  end

  def average(collection)
    (collection.sum / collection.length.to_f).round(2)
  end

  def average2(collection1, collection2)
    (collection1.sum / collection2.length.to_f).round(2)
  end

  def total_scores
    @games_list.map { |game| game.home_goals.to_i + game.away_goals.to_i }
  end

  def home_wins
    # tying to find all the home wins
    @games_list.select { |game| game.home_goals > game.away_goals}.length
  end

  def away_wins
    @games_list.select { |game| game.home_goals < game.away_goals}.length
  end

  def ties
    @games_list.select { |game| game.home_goals == game.away_goals}.length
  end

  def rival_id(id)
    number_id = id.to_i
    opponent_win_percentage(number_id).max_by do |id, percentage|
      percentage
    end.first
  end
end
