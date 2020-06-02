require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require_relative './team_collection'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = GameCollection.all(info[:games])
    @teams = TeamCollection.all(info[:teams])
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # League Statistics Methods
  def count_of_teams
    teams = CSV.read(@teams, headers: true)
    teams.count
  end

  def best_offense
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      GameTeams.new(row)
    end

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] > memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end
    correct_team
  end

  def worst_offense
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      GameTeams.new(row)
    end

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def highest_scoring_visitor
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      GameTeams.new(row)
    end

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end


  def highest_scoring_visitor
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "away"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    best_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] > memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == best_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def lowest_scoring_visitor
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "away"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def highest_scoring_home_team
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "home"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    best_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] > memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == best_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def lowest_scoring_home_team
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "home"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end


  # Season Statistic methods


  # Team Statistic methods

end
