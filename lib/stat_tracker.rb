require "csv"
require "pry"

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(CSV.read(locations[:games],     headers: true,     header_converters: :symbol), CSV.read(locations[:teams],     headers: true,     header_converters: :symbol), CSV.read(locations[:game_teams],     headers: true,     header_converters: :symbol))
  end

  def highest_total_score
    highest_total = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end

    highest_total.max
  end

  def lowest_total_score
    lowest_total = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end

    lowest_total.min
  end

  def percentage_home_wins
    home_wins = []
    all_home_games = []

    @game_teams.each do |row|
      home_wins << row if row[:hoa] == "home" && row[:result] == "WIN"
      all_home_games << row if row[:hoa] == "home"
    end

    ((home_wins.count / all_home_games.count.to_f).round(2))
  end

  def percentage_visitor_wins
    vistor_wins = []
    all_vistor_games = []

    @game_teams.each do |row|
      vistor_wins << row if row[:hoa] == "away" && row[:result] == "WIN"
      all_vistor_games << row if row[:hoa] == "away"
    end

    ((vistor_wins.count / all_vistor_games.count.to_f).round(2))
  end

  def percentage_ties
    ties = []
    all_games = []

    @game_teams.each do |row|
      ties << row if row[:result] == "TIE"
      all_games << row[:result]
    end

    ((ties.count / all_games.count.to_f).round(2))
  end

  def count_of_games_by_season
    game_count_by_season = Hash.new {  }

    games.each do |game|
      season_values = game[:season]

      if game_count_by_season[season_values].nil?
        game_count_by_season[season_values] = 0
      end

      game_count_by_season[season_values] += 1
    end

    game_count_by_season
  end

  def total_goals
    home_goals = 0
    away_goals = 0
    total_goals = 0

    @games.each do |game|
      home_goals += game[:home_goals].to_i
      away_goals += game[:away_goals].to_i
    end

    (home_goals + away_goals)
  end

  def total_games
    count_of_games_by_season.values.sum
  end

  def average_goals_per_game
    (total_goals / total_games.to_f).round(2)
  end
end
