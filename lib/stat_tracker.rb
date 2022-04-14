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



  ## SEASON STATISTICS : All methods return Strings

  def winningest_coach
    # Name of the Coach with the best win percentage for the season

  end

  def worst_coach
    # Name of the Coach with the worst win percentage for the season

  end

  def most_accurate_team
    # Name of the Team with the best ratio of shots to goals for the season

  end

  def least_accurate_team
    # Name of the Team with the worst ratio of shots to goals for the season

  end

  def most_tackles
    # Name of the Team with the most tackles in the season

  end

  def fewest_tackles
    # Name of the Team with the fewest tackles in the season

  end

end
