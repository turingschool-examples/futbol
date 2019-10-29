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
    (home_wins.length.to_f / @total_games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @total_games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / @total_games.length).round(2)
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

  def games_by_season(team_id)

    # home_team_id || away_team_id

    #if away_team_id == game.team_id

    game_season = {}
    games = @total_games.find_all do |game|
      team_id == game.away_team_id || game.home_team_id
        game_season[:game_id] = game.game_id
        game_season[:season] = game.season
        game_season[:away_team_id] = game.away_team_id
        game_season[:home_team_id] = game.home_team_id
        require "pry"; binding.pry
    end
    games
  end

  def total_home_games
   total_home_games = @total_games.count {|game| game.home_team_id == "26"}
  end

  def total_home_wins
   total_home_wins = @total_games.count {|game| game.home_team_id == "26" && game.home_goals > game.away_goals}
  end
end
