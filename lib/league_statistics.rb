require 'csv'
require_relative './game_team'
require_relative './team'
require_relative './game'

class LeagueStatistics
  attr_reader :teams,
              :game_teams

  def initialize(teams, game_teams)
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(game_teams_filepath,teams_filepath)
    game_teams = []

    CSV.foreach(game_teams_filepath, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end

    teams = []

    CSV.foreach(teams_filepath, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end

    new(teams, game_teams)
  end

  def count_of_teams
    @teams.size
  end

  def best_offense
    teams_goals = {}
    @game_teams.each do |game_team|
      team_id = game_team.team_id
      goals = game_team.goals.to_f
      teams_goals[team_id] ||= []
      teams_goals[team_id] << goals
    end

    average_goals = teams_goals.transform_values { |goals| goals.sum / goals.size.to_f }
    best_team_id = average_goals.key(average_goals.values.max)

    best_team = @teams.find { |team| team.team_id == best_team_id }
    best_team.teamname
  end

  def worst_offense
    teams_goals = {}

    @game_teams.each do |game_team|
      team_id = game_team.team_id
      goals = game_team.goals.to_f
      teams_goals[team_id] ||= []
      teams_goals[team_id] << goals
    end

    average_goals = teams_goals.transform_values { |goals| goals.sum / goals.size.to_f }
    worst_team_id = average_goals.key(average_goals.values.min)

    worst_team = @teams.find { |team| team.team_id == worst_team_id }
    worst_team.teamname
  end

  def highest_scoring_visitor
    away_teams = @game_teams.select { |game_team| game_team.hoa == 'away' }
    highest_scorer = away_teams.max_by { |game_team| game_team.goals.to_i }

    best_team = @teams.find { |team| team.team_id == highest_scorer.team_id }
    best_team.teamname
  end

  def lowest_scoring_visitor
    away_teams = @game_teams.select { |game_team| game_team.hoa == 'away' }
    lowest_scorer = away_teams.min_by { |game_team| game_team.goals.to_i }

    worst_team = @teams.find { |team| team.team_id == lowest_scorer.team_id }
    worst_team.teamname
  end

  def average_scoring_home_team
    home_team_goals = Hash.new(0)
    home_team_games = Hash.new(0)

    game_teams.each do |game_team|
      if game_team.hoa == "home"
        home_team_goals[game_team.team_id] += game_team.goals
        home_team_games[game_team.team_id] += 1
      end
    end

    home_team_average_goals = Hash.new(0)
    home_team_games.each do |team_id, games|
      home_team_average_goals[team_id] = ((home_team_goals[team_id]/games).to_f).round(2)
    end

    home_team_average_goals
  end

  def highest_scoring_home_team
    highest_scoring_home_team_id = average_scoring_home_team.max_by {|_, goals| goals }.first

    highest_scoring_home_team = teams.find { |team| team.team_id == highest_scoring_home_team_id  }
    highest_scoring_home_team.teamname
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team_id = average_scoring_home_team.min_by {|_, goals| goals }.first

    lowest_scoring_home_team = teams.find { |team| team.team_id == lowest_scoring_home_team_id  }
    lowest_scoring_home_team.teamname
  end

end
