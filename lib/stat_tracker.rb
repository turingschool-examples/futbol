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

  ## GAME STATISTICS

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end


  ## LEAGUE STATISTICS - JENN

  ## total number of teams in the data
  def count_of_teams

  end
  
  ##Name of the team with the highest average number of goals scored per game across all seasons.
  # def best_offense
  # end
  #
  ##Name of the team with the lowest average number of goals scored per game across all seasons.
  # def worst_offense
  # end
  #
  ##Name of the team with the highest average score per game across all seasons when they are away.
  # def highest_scoring_visitor
  # end
  #
  ##Name of the team with the highest average score per game across all seasons when they are home
  # def highest_scoring_home_team
  # end
  #
  ##Name of the team with the lowest average score per game across all seasons when they are a visitor.
  # def lowest_scoring_visitor
  # end
  #
  ##Name of the team with the lowest average score per game across all seasons when they are at home.
  # def lowest_scoring_home_team
  # end



end
