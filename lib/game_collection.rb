require_relative 'game'
require 'CSV'

class GameCollection
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    game_array = []
      CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol) do |row|
        game_array << Game.new(row)
      end
    game_array
  end

  def highest_total_score
    highest_total = @games.max_by{ |game| game.away_goals + game.home_goals }
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = @games.min_by{ |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

  def biggest_blowout
    blowout = @games.max_by { |game| (game.home_goals - game.away_goals).abs }
    (blowout.home_goals - blowout.away_goals).abs
  end

  def percentage_home_wins
    h_win = @games.count { |game| game.away_goals < game.home_goals }
    ((h_win * 100.00).to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    v_win = @games.count { |game| game.away_goals > game.home_goals }
    ((v_win * 100.00).to_f / @games.length).round(2)
  end

  def percentage_ties
    ties = @games.count { |game| game.away_goals == game.home_goals }
    ((ties * 100.00).to_f / @games.length).round(2)
  end

  def count_of_games_by_season
   @games.reduce({}) do |game_count, game|
      if game_count[game.season]
        game_count[game.season] += 1
      else
        game_count[game.season] = 1
      end
      game_count
    end
  end

  def goal_count_per_season
    @games.reduce({}) do |goal_count, game|
      if goal_count[game.season]
        goal_count[game.season] += (game.away_goals + game.home_goals)
      else
        goal_count[game.season] = (game.away_goals + game.home_goals)
      end
      goal_count
    end
  end

  def average_goals_by_season
    goal_count_per_season.merge(count_of_games_by_season) do |key, goal_count, game_count|
      (goal_count.to_f / game_count).round(2)
    end
  end

  def average_goals_per_game
    goals = @games.reduce(0) do |total_goals, game|
      total_goals += (game.away_goals + game.home_goals)
    end
    (goals.to_f / @games.length).round(2)
  end

  def number_away_games_by_away_team_id
    @games.reduce(Hash.new(0)) do |games_by_id, game|
      games_by_id[game.away_team_id] += 1
      games_by_id
    end
  end

  def total_away_goals_by_away_team_id
    @games.reduce(Hash.new(0)) do |total_goals_by_id, game|
      total_goals_by_id[game.away_team_id] += game.away_goals
      total_goals_by_id
    end
  end

  def average_away_goals_by_away_team_id
    total_away_goals_by_away_team_id.merge(number_away_games_by_away_team_id) do |away_team_id, total_goals, total_games|
      total_goals / total_games
    end
  end

  def away_team_id_for_highest_average_goals
    highest_average = average_away_goals_by_away_team_id.values.sort.last
    average_away_goals_by_away_team_id.key(highest_average)
  end
end
