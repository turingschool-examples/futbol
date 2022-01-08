require 'pry'
require 'CSV'
require './lib/games_collection'
require './lib/teams_collection'
require './lib/games_teams_collection'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations
    @games_file = GamesCollection.new(@locations[:games])
    @teams_file = TeamsCollection.new(@locations[:teams])
    @game_teams_file = GamesTeamsCollection.new(@locations[:game_teams])
    @read_games = @games_file.read_file
    @read_teams = @teams_file.read_file
    @read_game_teams = @game_teams_file.read_file
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def count_of_teams
    @read_teams.size
  end

  def best_offense
    result = {}
    @read_game_teams.each do |row|
      if result[row.team_id].nil?
        result[row.team_id] = [row.goals.to_i]
      else
        result[row.team_id] << row.goals.to_i
      end
    end

    result_2 = average_goals(result)

    y = result_2.max_by {|key, value| value}

    @read_teams.find_all do |row|
      return row.teamname if y[0] == row.team_id
    end
  end

  def average_goals(argument_1)
    result_2 = {}
    argument_1.each do |key, value|
      result_2[key] = value.sum / value.size.to_f
    end
  end

  def worst_offense
    result = {}
    @read_game_teams.each do |row|
      if result[row.team_id].nil?
        result[row.team_id] = [row.goals.to_i]
      else
        result[row.team_id] << row.goals.to_i
      end
    end

    result_2 = {}
    result.each do |key, value|
      result_2[key] = value.sum / value.size.to_f
    end
    y = result_2.min_by {|key, value| value}

    @read_teams.find_all do |row|
      return row.teamname if y[0] == row.team_id
    end
  end

  def highest_scoring_visitor
    hash_for_away_teams = {}
    @read_games.each do |row|
      if hash_for_away_teams[row.away_team_id].nil?
        hash_for_away_teams[row.away_team_id] = [row.away_goals.to_i]
      else
        hash_for_away_teams[row.away_team_id] << row.away_goals.to_i
      end
    end

    hash_for_average_goals_away = {}
    hash_for_away_teams.each do |team_id, team_id_goals|
      hash_for_average_goals_away[team_id] = team_id_goals.sum / team_id_goals.size.to_f
    end

    away_highest_average = hash_for_average_goals_away.max_by {|team_id, team_id_goals| team_id_goals}

    @read_teams.find_all do |row|
      return row.teamname if away_highest_average[0] == row.team_id
    end
  end

  def highest_scoring_home_team
    hash_for_home_teams = {}
    @read_games.each do |row|
      if hash_for_home_teams[row.home_team_id].nil?
        hash_for_home_teams[row.home_team_id] = [row.home_goals.to_i]
      else
        hash_for_home_teams[row.home_team_id] << row.home_goals.to_i
      end
    end

    hash_for_average_goals_home = {}
    hash_for_home_teams.each do |team_id, team_id_goals|
      hash_for_average_goals_home[team_id] = team_id_goals.sum / team_id_goals.size.to_f
    end

    home_highest_average = hash_for_average_goals_home.max_by {|team_id, team_id_goals| team_id_goals}

    @read_teams.find_all do |row|
      return row.teamname if home_highest_average[0] == row.team_id
    end
  end

  def lowest_scoring_visitor
    hash_for_away_teams = {}
    @read_games.each do |row|
      if hash_for_away_teams[row.away_team_id].nil?
        hash_for_away_teams[row.away_team_id] = [row.away_goals.to_i]
      else
        hash_for_away_teams[row.away_team_id] << row.away_goals.to_i
      end
    end

    hash_for_average_goals_away = {}
    hash_for_away_teams.each do |team_id, team_id_goals|
      hash_for_average_goals_away[team_id] = team_id_goals.sum / team_id_goals.size.to_f
    end

    away_lowest_average = hash_for_average_goals_away.min_by {|team_id, team_id_goals| team_id_goals}

    @read_teams.find_all do |row|
      return row.teamname if away_lowest_average[0] == row.team_id
    end
  end

end
