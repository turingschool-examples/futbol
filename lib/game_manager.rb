require 'CSV'
require 'pry'

require_relative './games'

class GameManager
  attr_reader :game_objects, :game_path

  def initialize(game_path)
    @game_path = './data/games.csv'
    # @stat_tracker = stat_tracker
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
    percent_wins = away_team_wins_count.to_f / 7441
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
    percent_ties = ties_count.to_f / 7441
    percent_ties.round(2)
  end

  def count_of_games_by_season
    games_count = @game_objects.group_by {|s| s.season.to_s}.map {|k, v| [k, v.count]}.sort_by(&:last)
    Hash[games_count]
  end

end
