require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'


class StatTracker

attr_reader :games, :team, :game_teams

  def initialize(locations)
    @games = read_and_create_games(locations[:games])
    @teams = read_and_create_teams(locations[:teams])
    @game_teams = read_and_create_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  def read_and_create_games(games_csv)
    games_array = []
    CSV.foreach(games_csv, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def read_and_create_teams(teams_csv)
    teams_array = []
    CSV.foreach(teams_csv, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def read_and_create_game_teams(game_teams_csv)
    game_teams_array = []
    CSV.foreach(game_teams_csv, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    home_wins = []
    @games.each do |game|
      if game.home_goals > game.away_goals
        home_wins << game
      end
    end
    (home_wins.count / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = []
    @games.each do |game|
      if game.away_goals > game.home_goals
        visitor_wins << game
      end
    end
    (visitor_wins.count / @games.count.to_f).round(2)
  end

  def percentage_ties
    total_ties = []
    @games.each do |game|
      if game.away_goals == game.home_goals
        total_ties << game
      end
    end
    (total_ties.count / @games.count.to_f).round(2)
  end

  def count_of_games_by_season
    @games.group_by { |total| total.season }.transform_values do |values| values.count
    end
  end

  def count_of_goals_by_season
    goals_by_season = {}
    @games.each do |game|
      if goals_by_season[game.season].nil?
        goals_by_season[game.season] = game.home_goals + game.away_goals
      else
        goals_by_season[game.season] += game.home_goals + game.away_goals
      end
    end
    goals_by_season
  end

  def average_goals_per_game
    total_goals = @games.map {|game| game.away_goals + game.home_goals}
    average = total_goals.sum.to_f / @games.count
    average.round(2)
  end

  def average_goals_by_season
    average_goals = {}
    count_of_goals_by_season.each do |season, goals|
      average_goals[season] = (goals.to_f / count_of_games_by_season[season]).round(2)
    end
    average_goals
  end
end
