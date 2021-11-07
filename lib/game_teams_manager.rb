require 'CSV'
require 'pry'

require_relative './game_teams'
require_relative './teams_manager'

class GameTeamsManager
  attr_reader :game_teams_objects, :game_teams_path, :teams, :games

  def initialize(game_teams_path)
    @game_teams_path = './data/game_teams.csv'
    @game_teams_objects = (
      objects = []
      CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
        objects << GameTeams.new(row)
      end
      objects)
    @teams = TeamManager.new('./data/teams.csv').team_objects

    @games = GameManager.new('./data/games.csv').game_objects
    # team_manager = TeamManager.new('./data/teams.csv')
    # @teams = team_manager.team_objects

  end

  def games_by_team_id(team_id, hoa = nil)
    @game_teams_objects.find_all do |game|
      if hoa == nil
        game.team_id == team_id
      else
        game.hoa == hoa && game.team_id == team_id
      end
    end
  end

  def total_goals_by_team(team_id, hoa = nil)
    games_by_team_id(team_id, hoa).sum do |game|
      game.goals
    end
  end

  def average_goals_per_game_by_id(team_id, hoa = nil)
    average = total_goals_by_team(team_id, hoa) / games_by_team_id(team_id, hoa).count.to_f
    average.round(2)

  end

  def wins_by_team_id(team_id, hoa = nil) #test
    games_by_team_id(team_id, hoa).find_all do |game|
        game.result == "WIN"
    end
  end

  def average_win_percentage(team_id, hoa = nil) #test
    win_percent = wins_by_team_id(team_id, hoa).count
    other_percent = games_by_team_id(team_id, hoa).count
    total = win_percent.to_f/other_percent
    total.round(2)
  end

  # def winning_coach #test
  #   best_coach = teams.max_by { |team| win_percent_by_id(team.team_id) }
  #   best_coach.teamname
  #
  # end
  # def losing_coach #test
  #   worst_coach = teams.min_by { |team| win_percent_by_id(team.team_id) }
  #   worst_coach.teamname



  def best_offense
    best_team = teams.max_by { |team| average_goals_per_game_by_id(team.team_id) }
    best_team.teamname
  end

  def worst_offense
    worst_team = teams.min_by { |team| average_goals_per_game_by_id(team.team_id) }
    worst_team.teamname

  end

  def highest_scoring_visitor
    highest_visitor = teams.max_by { |team| average_goals_per_game_by_id(team.team_id, "away") }
    highest_visitor.teamname
  end

  def highest_scoring_home_team
    highest_home = teams.max_by { |team| average_goals_per_game_by_id(team.team_id, "home") }
    highest_home.teamname
  end

  def lowest_scoring_visitor
    lowest_visitor = teams.min_by { |team| average_goals_per_game_by_id(team.team_id, "away") }
    lowest_visitor.teamname
  end

  def lowest_scoring_home_team
    lowest_home = teams.min_by { |team| average_goals_per_game_by_id(team.team_id, "home") }
    lowest_home.teamname
  end



  def total_tackles_by_team_id(team_id, hoa = nil)
    games_by_team_id(team_id, hoa).sum do |game|
      game.tackles
    end
  end

  def tackles_by_season
    seasons = @games.group_by {|game| game.season}

    #if statement. if season == 20122013, return most takcles method
    require "pry"; binding.pry
  end

  def most_tackles
    high_tackles = teams.max_by { |team| total_tackles_by_team_id(team.team_id) }
    high_tackles.teamname
  end
end
