require_relative './game'
require_relative './team'
require_relative './game_teams'

require_relative './game_collection'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)

    @games = GameCollection.new(info[:games])
    @teams = info[:teams]
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistics Methods
  # def highest_total_score
  #   games.all.map do |game|
  #     game.away_goals.to_i + game.home_goals.to_i
  #   end.max
  # end
  #
  # def lowest_total_score
  #   games.all.map do |game|
  #     game.away_goals.to_i + game.home_goals.to_i
  #   end.min
  # end
  #
  # def percentage_home_wins
  #   home_wins = 0
  #   games.all.each do |game|
  #     home_wins += 1 if game.home_goals.to_i > game.away_goals.to_i
  #   end
  #   (home_wins.to_f / games.all.size).round(2)
  # end
  #
  # def percentage_visitor_wins
  #   visitor_wins = 0
  #   games.all.each do |game|
  #     visitor_wins += 1 if game.away_goals.to_i > game.home_goals.to_i
  #   end
  #   (visitor_wins.to_f / games.all.size).round(2)
  # end
  #
  # def percentage_ties
  #   ties = 0
  #   games.all.each do |game|
  #     ties += 1 if game.away_goals.to_i == game.home_goals.to_i
  #   end
  #   (ties.to_f / games.all.size).round(2)
  # end
  #
  # def count_of_games_by_season
  #   games_by_season = Hash.new(0)
  #   games.all.each do |game|
  #     games_by_season[game.season] += 1
  #   end
  #   games_by_season
  # end
  #
  # def average_goals_per_game
  #   average_goals = 0
  #   games.all.each do |game|
  #     average_goals += game.away_goals.to_i
  #     average_goals += game.home_goals.to_i
  #   end
  #   (average_goals.to_f / games.all.count).round(2)
  # end
  #
  # def initialize
  #   @games = info[:games]
  #   @teams = info[:teams]
  #   @game_teams = info[:game_teams]
  # end
  #
  # def self.from_csv(info)
  #   StatTracker.new(info)
  # end

  # League Statistic methods
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
