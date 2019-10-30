require 'csv'
require_relative 'game'

class GameCollection
  attr_reader :games

  def initialize(csv_path)
    @games = create_games(csv_path)
  end

  def create_games(csv_path)
    csv = CSV.read("#{csv_path}", headers: true, header_converters: :symbol)
    csv.map {|row| Game.new(row)}
  end

  def total_games
    @games.length
  end

  def find_count_of_game_by_season
    games_per_season = Hash.new(0)
      @games.each {|game| games_per_season[game.season] += 1}
      games_per_season.sort.to_h
  end

  def find_average_goals_per_game
    total_goals = @games.sum {|game| game.total_score}
      (total_goals.to_f/total_games).round(2)
  end

  def find_highest_total_score
    @games.max_by {|game| game.total_score}.total_score
  end

  def find_lowest_total_score
    @games.min_by {|game| game.total_score}.total_score
  end

  def find_average_goals_by_season
    calculate_total_goals_by_season.merge(find_count_of_game_by_season) do |season, goals, games|
      (goals/games).round(2)
    end
  end

  def calculate_total_goals_by_season
    @games.reduce(Hash.new(0)) do |acc, game|
      acc[game.season] += game.total_score.to_f
      acc
    end
  end

  def calculate_goal_differences
    @games.max_by {|game| game.game_goal_difference}.game_goal_difference
  end

  def find_percentage_home_wins
    home_games_won = @games.count {|game| game.home_team_win?}.to_f
    (home_games_won/total_games).round(2)
  end

  def find_percentage_away_wins
    away_games_won = @games.count {|game| game.visitor_team_win?}.to_f
    (away_games_won/total_games).round(2)
  end

  def find_percentage_of_ties
    tied_games = @games.count {|game| game.tie_game?}.to_f
    (tied_games/total_games).round(2)
  end


  def find_number_of_home_games
    number_of_home_games = Hash.new()
    @games.each do |game|
      home_team_id = game.home_team_id
      if number_of_home_games.has_key?(home_team_id)
        number_of_home_games[home_team_id] = number_of_home_games[home_team_id] + 1
      else
        number_of_home_games[home_team_id] = 1
      end
    end
    number_of_home_games
  end

  def find_number_of_away_games
    number_of_away_games = Hash.new()
    @games.each do |game|
      away_team_id = game.away_team_id
      if number_of_away_games.has_key?(away_team_id)
        number_of_away_games[away_team_id] = number_of_away_games[away_team_id] + 1
      else
        number_of_away_games[away_team_id] = 1
      end
    end
    number_of_away_games
  end

  def find_total_home_score
    total_home_score = Hash.new()
    @games.each do |game|
      home_team_id = game.home_team_id
      if total_home_score.has_key?(home_team_id)
        total_home_score[home_team_id] = total_home_score[home_team_id] + game.home_goals
      else
        total_home_score[home_team_id] = game.home_goals
      end
    end
    total_home_score
  end

  def find_total_away_score
    total_away_score = Hash.new()
    @games.each do |game|
      away_team_id = game.away_team_id
      if total_away_score.has_key?(away_team_id)
        total_away_score[away_team_id] = total_away_score[away_team_id] + game.away_goals
      else
        total_away_score[away_team_id] = game.away_goals
      end
    end
    total_away_score
  end

  def find_average_home_goals_per_home_game
    average_home_goals = Hash.new
    total_home_score = find_total_home_score
    total_home_games = find_number_of_home_games

    total_home_score.each do |home_team_id, home_score|
      total_games = total_home_games[home_team_id].to_f
      average_home_goals[home_team_id] = (home_score / total_games).round(2)
    end
    average_home_goals
  end

  def find_average_away_goals_per_away_game
    average_away_goals = Hash.new
    total_away_score = find_total_away_score
    total_away_games = find_number_of_away_games

    total_away_score.each do |away_team_id, away_score|
      total_games = total_away_games[away_team_id].to_f
      average_away_goals[away_team_id] = (away_score / total_games).round(2)
    end
    average_away_goals
  end

  def find_highest_average_home_score_per_home_game
    avg_home_score_per_home_game = find_average_home_goals_per_home_game
    highest_scoring_home_team = avg_home_score_per_home_game.max_by{|team_id, avg_home_score| avg_home_score}
    highest_scoring_home_team[0]
  end

  def find_highest_average_away_score_per_away_game
    avg_away_score_per_away_game = find_average_away_goals_per_away_game
    highest_scoring_away_team = avg_away_score_per_away_game.max_by{|team_id, avg_away_score| avg_away_score}
    highest_scoring_away_team[0]
  end

  def find_lowest_average_home_score_per_home_game
    avg_home_score_per_home_game = find_average_home_goals_per_home_game
    lowest_scoring_home_team = avg_home_score_per_home_game.min_by{|team_id, avg_home_score| avg_home_score}
    lowest_scoring_home_team[0]
  end

  def find_lowest_average_away_score_per_away_game
    avg_away_score_per_away_game = find_average_away_goals_per_away_game
    lowest_scoring_away_team = avg_away_score_per_away_game.min_by{|team_id, avg_away_score| avg_away_score}
    lowest_scoring_away_team[0]
  end
end
