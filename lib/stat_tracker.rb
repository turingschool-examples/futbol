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


## LEAGUE STATISTICS - JENN ##

  def count_of_teams
    @teams.count
  end

  #helper_methods that are used for best_offense and worse_offense

  def games_by_team
    games_by_team_hash = {}
    @game_teams.each do |game|
      if games_by_team_hash[game.team_id].nil?
        games_by_team_hash[game.team_id] = { goals: game.goals, number_of_games: 1 }
      else
        games_by_team_hash[game.team_id][:goals] += game.goals
        games_by_team_hash[game.team_id][:number_of_games] += 1
      end
    end
    games_by_team_hash
  end

  def average_score_by_team
    average_hash = {}
    games_by_team.each do |key, value|
      average_hash[key] = value[:goals].to_f / value[:number_of_games]
    end
    average_hash
  end

  ## best_offense
  def best_offense
    best_offense_team = @teams.find do |team|
      team.team_id == average_score_by_team.sort_by{|k, v| v}.last[0]
    end
    best_offense_team.team_name
  end

    ##worst_offense
  def worst_offense
    worst_offense_team = @teams.find do |team|
      team.team_id == average_score_by_team.sort_by{|k, v| v}.first[0]
    end
    worst_offense_team.team_name
  end

end
