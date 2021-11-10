require 'CSV'
require 'pry'

require_relative './games'

class GameManager
  attr_reader :game_objects, :game_path

  def initialize(game_path)
    @game_path = './data/games.csv'

    @game_objects = (
      objects = []
      CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
        objects << Games.new(row)
      end
      objects)
  end

  def highest_total_score
    @game_objects.map do |game|
      game.home_goals + game.away_goals
    end.max

  end

  def lowest_total_score
    @game_objects.map do |game|
      game.home_goals + game.away_goals
    end.min
  end

  def percentage_home_wins
    home_team_wins = []
    @game_objects.each do |row|
      if row.home_goals > row.away_goals
        home_team_wins << row.home_goals
      end
    end
    home_team_wins_count = home_team_wins.count
    percent_wins = home_team_wins_count.to_f / 7441
    percent_wins.round(2)
  end

  def percentage_visitor_wins
    away_team_wins = []
    @game_objects.each do |row|
      if row.home_goals < row.away_goals
        away_team_wins << row.away_goals
      end
    end
    away_team_wins_count = away_team_wins.count
    percent_wins = away_team_wins_count.to_f / game_objects.count
    percent_wins.round(2)

  end

  def percentage_ties
    ties = []
    @game_objects.each do |row|
      if row.home_goals == row.away_goals
        ties << row.away_goals
      end
    end
    ties_count = ties.count
    percent_ties = ties_count.to_f / game_objects.count
    percent_ties.round(2)
  end

  def count_of_games_by_season
    games_count = @game_objects.group_by {|s| s.season.to_s}.map {|k, v| [k, v.count]}.sort_by(&:last)
    Hash[games_count]
  end

  def number_of_seasons
    seasons = []
    @game_objects.each do |row|
        seasons << row.season
    end
    seasons.uniq.count
  end

  def array_away_team_ids
    away_id = []
      @game_objects.each do |row|
        away_id << row.away_team_id
      end
    away_id.uniq
  end

  def average_goals_per_game
    goals_array = @game_objects.map do |game|
      game.away_goals + game.home_goals
    end
    goals_in_game = goals_array.sum
    avg_goals_per_game = goals_in_game.to_f / game_objects.count
    avg_goals_per_game.round(2)
  end

  def average_goals_by_season
    seasons = @game_objects.group_by {|game| game.season}
    seasons.each do |season, all_games_by_season|
        total_goals = all_games_by_season.sum {|game| game.away_goals + game.home_goals}
        avg = (total_goals.to_f / all_games_by_season.count)
        seasons[season] = avg.round(2)
    end
  end
end
