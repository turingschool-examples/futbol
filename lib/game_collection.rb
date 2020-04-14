require 'csv'
require_relative 'game'
require_relative 'collection'
require_relative 'modules/mathable'
require_relative 'modules/findable'

class GameCollection < Collection
  include Mathable
  include Findable
  attr_reader :games_list

  def initialize(file_path)
    @games_list = create_objects(file_path, Game)
  end

  def total_games_per_season(id)
    all_games_by_season(id).reduce({}) do |total, (season, games)|
      total[season] = games.length
      total
    end
  end

  def wins_in_season(id)
    all_games_by_season(id).reduce(Hash.new(0)) do |season_wins, (season, games)|
      wins = games.count do |game|
        (game.home_team_id == id && game.home_team_win?)||(game.away_team_id == id && game.visitor_team_win?)
      end
        season_wins[season] += wins
        season_wins
    end
  end

  def win_percentage(id)
    wins = wins_in_season(id)
    total = total_games_per_season(id)
    wins.merge(total) {|season, wins, games|(wins.to_f/games).round(2) * 100}
  end

  def best_season(id)
    (win_percentage(id.to_i).max_by {|season, percentage|percentage}).first
  end

  def worst_season(id)
    (win_percentage(id.to_i).min_by {|season, percentage|percentage}).first
  end

  def opponent_stats(id)
    total_games = all_games(id.to_i)
    opponent_hash = Hash.new{|id, games| id[games] = []}
    total_games.each do |game|
      opponent_hash[game.home_team_id] << game
      opponent_hash[game.away_team_id] << game
      opponent_hash.delete(id)
    end
    opponent_hash
  end

  def opponent_total_games_played(id)
    opponent_stats(id).reduce({}) do |total, (id, games)|
    total[id] = games.length
    total
    end
  end

  def opponent_wins(id)
    opponent_stats(id.to_i).reduce(Hash.new(0)) do |opponent_wins, (id, games)|
      wins = games.count do |game|
        (game.home_team_id == id && game.home_team_win?)||(game.away_team_id == id && game.visitor_team_win?)
      end
      opponent_wins[id] += wins
      opponent_wins
    end
  end

  def opponent_win_percentage(id)
    wins = opponent_wins(id.to_i)
    total = opponent_total_games_played(id.to_i)
    wins.merge(total) {|id, wins, games|(wins.to_f/games).round(2) * 100}
  end

  def favorite_opponent_id(id)
    (opponent_win_percentage(id.to_i).min_by {|id, percentage| percentage}).first
  end

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def percentage_home_wins
    percentage(home_wins, @games_list)
  end

  def percentage_visitor_wins
    percentage(away_wins, @games_list)
  end

  def percentage_ties
    percentage(ties, @games_list)
  end

  def count_of_games_by_season
    @games_list.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    average(total_scores, games_list)
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
    (opponent_win_percentage(id.to_i).max_by {|id, percentage| percentage}).first
  end
end
