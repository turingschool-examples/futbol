require 'csv'
require_relative './game.rb'

class GameCollection
  attr_reader :total_games

  def initialize(game_path)
    @total_games = create_games(game_path)
  end

# created class method in Game to find all_games
  def create_games(game_path)
    csv = CSV.read(game_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      Game.new(row)
    end
  end

  #method to sort by total goals
  #max_by { \game| game. away + game. home}
  #min_by ""
  # OR just sort game_sums and pull the first/last
  def highest_total_score
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max_by { |sum| sum }
  end

  def lowest_total_score
    #game_sums has been used the same twice now
    game_sums = @total_games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min_by { |sum| sum }
  end

  def biggest_blowout
    game_differences = @total_games.map do |game|
      (game.home_goals - game.away_goals).abs
    end
    game_differences.max_by { |difference| difference }
  end

  def percentage_home_wins
    home_wins = @total_games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / @total_games.length * 100).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @total_games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / @total_games.length * 100).round(2)
  end

  def percentage_ties
    ties_count = @total_games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count / @total_games.count.to_f).round(2)
  end

  def count_of_games_by_season
    count_games_by_season_list = {}
    @total_games.each do |game|
      count_games_by_season_list[game.season] = 0
    end
    @total_games.each do |game|
      count_games_by_season_list[game.season] += 1
    end
    return count_games_by_season_list
  end

  def average_goals_per_game
    total_goals = 0
    @total_games.each do |game|
      total_goals += game.home_goals
      total_goals += game.away_goals
    end
    (total_goals / @total_games.count.to_f).round(2)
  end

  def group_by_away_team_id_and_goals
    away_team_groups = @total_games.flat_map { |game| game.away_team_id}
    away_team_goals = @total_games.flat_map { |game| game.away_goals}
    away_team_id_goals = away_team_groups.zip(away_team_goals)
  end

  def group_by_home_team_id_and_goals
    home_team_groups = @total_games.flat_map { |game| game.home_team_id}
    home_team_goals = @total_games.flat_map { |game| game.home_goals}
    home_team_id_goals = home_team_groups.zip(home_team_goals)
  end

  def sum_of_away_games
    team_to_total_away_goals = {}
    group_by_away_team_id_and_goals.each do |game|
      if team_to_total_away_goals.has_key?(game.first)
        old_score = team_to_total_away_goals[game.first]
        new_score = old_score + game[1]
        team_to_total_away_goals[game[0]] = new_score
      else
        team_to_total_away_goals[game[0]] = game[1]
      end
    end
    team_to_total_away_goals
  end

  def sum_of_home_games
    team_to_total_home_goals = {}
    group_by_home_team_id_and_goals.each do |game|
      if team_to_total_home_goals.has_key?(game.first)
        old_score = team_to_total_home_goals[game.first]
        new_score = old_score + game[1]
        team_to_total_home_goals[game[0]] = new_score
      else
        team_to_total_home_goals[game[0]] = game[1]
      end
    end
    team_to_total_home_goals
  end

  def count_of_away_games
    total_away_games = {}
    group_by_away_team_id_and_goals.each do |game|
      if total_away_games.has_key?(game.first)
        old_count = total_away_games[game.first]
        new_count = old_count + 1
        total_away_games[game[0]] = new_count
      else
        total_away_games[game[0]] = 1
      end
    end
    total_away_games
  end

  def count_of_home_games
    total_home_games = {}
    group_by_home_team_id_and_goals.each do |game|
      if total_home_games.has_key?(game.first)
        old_count = total_home_games[game.first]
        new_count = old_count + 1
        total_home_games[game[0]] = new_count
      else
        total_home_games[game[0]] = 1
      end
    end
    total_home_games
  end

  def highest_average_away_goals
    highest_away_team_id = -1
    highest_away_average = -1
    count_of_away_games.each do |team_id, away_game|
      average = sum_of_away_games[team_id] / away_game
      if average > highest_away_average
        highest_away_average = average
        highest_away_team_id = team_id
      end
    end
    highest_away_team_id
  end

  def highest_average_home_goals
    highest_home_team_id = -1
    highest_home_average = -1
    count_of_home_games.each do |team_id, home_game|
      average = sum_of_home_games[team_id] / home_game
      if average > highest_home_average
        highest_home_average = average
        highest_home_team_id = team_id
      end
    end
    highest_home_team_id
  end

  def average_goals_by_season
    season_list = count_of_games_by_season
    season_list.transform_values! do |total_season_games|
      [total_season_games, 0]
      # transforming hash so that..
      # Season (key value) = [total games of season, total goals of season]
      # transform again dividing goals/games to get average for each season
    end
    @total_games.each do |game|
      season_list[game.season][1] += game.home_goals
      season_list[game.season][1] += game.away_goals
    end
    season_list.transform_values do |total_season_games|
      (total_season_games[1] / total_season_games[0].to_f).round(2)
    end
  end
end
