require 'csv'
require './lib/game'
require './lib/game_team'
require './lib/team'
require './lib/league'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :league

  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @games = games_array_creator(locations[:games])
    @teams = teams_array_creator(locations[:teams])
    @game_teams = game_teams_array_creator(locations[:game_teams])
    @league = League.new(@games, @teams, @game_teams)
  end

  def games_array_creator(path)
    games_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def teams_array_creator(path)
    teams_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def game_teams_array_creator(path)
    game_teams_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end

#Game Statistics Methods
  def highest_total_score
    @league.total_goals.max
  end

  def lowest_total_score
    @league.total_goals.min
  end

  def percentage_home_wins





  end

  def percentage_visitor_wins





  end

  def percentage_ties





  end

  def count_of_games_by_season
    @league.games_by_season
  end

  def average_goals_per_game
    (@league.total_goals.sum(0.0) / @league.total_goals.length).round(2)
  end

  def average_goals_by_season





  end
  #League Statistics Methods
  def count_of_teams
    @league.team_names.count
  end

  def best_offense
    max = @league.avg_goals_by_team_id.max_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(max[0])
  end

  def worst_offense
    min = @league.avg_goals_by_team_id.min_by{|team_id, avg_goals| avg_goals}
    @league.team_id_to_team_name(min[0])
  end

  def highest_scoring_visitor





  end

  def lowest_scoring_visitor





  end

  def highest_scoring_home_team





  end

  def lowest_scoring_home_team





  end
#Season Statistics Methods
  def winningest_coach(season)

    @league.coaches_by_win_percentage(season).max_by do |coach, win_percentage|
      win_percentage
    end[0]

  end

  def worst_coach(season)

    @league.coaches_by_win_percentage(season).min_by do |coach, win_percentage|
      win_percentage
    end[0]

  end

  def most_accurate_team(season)
    team_id = @league.teams_by_accuracy(season).max_by do |team, accuracy|
      accuracy
    end[0]
    @league.team_id_to_team_name(team_id)

  end

  def least_accurate_team(season)
    team_id = @league.teams_by_accuracy(season).min_by do |team, accuracy|
      accuracy
    end[0]
    @league.team_id_to_team_name(team_id)

  end

  def most_tackles(season)





  end

  def fewest_tackles(season)





  end
#Team Statistics Methods
  def team_info(given_team_id)





  end

  def best_season(given_team_id)





  end

  def worst_season(given_team_id)





  end

  def average_win_percentage(given_team_id)





  end

  def most_goals_scored(team_id)





  end

  def fewest_goals_scored(team_id)




  end

  def favorite_opponent(given_team_id)





  end

  def rival(given_team_id)





  end

end
