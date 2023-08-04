require 'csv'
require_relative 'team'
require_relative 'game'
require_relative "game_team"
require_relative 'game_statable'
require_relative 'league_statable'

class StatTracker
include GameStatable
include LeagueStatable

  attr_reader :games, :teams, :game_teams

  def initialize(files)
    @games = (CSV.foreach files[:games], headers: true, header_converters: :symbol).map do |row|
      Game.new(row)
    end
    @teams = (CSV.foreach files[:teams], headers: true, header_converters: :symbol).map do |row|
      Team.new(row)
    end
    @game_teams = (CSV.foreach files[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeam.new(row)
    end
  end

  def most_accurate_team(season)
    # name of team with the best ratio of shots to goals for the season 
    # 1. pull out all game_id for a season in @games as an array
    # 2. iterate over @game_teams using our created array of game_id as reference
      # make hash of team_id as keys and set values to [goals + itself, shots + itself]
    # 3. use transform_values on hash to give goals / shots .round(4)
    # 4. Find the max value and subsequent key and return the team_name with team_list

    # 1. array of all game_id from a season
    all_season_game_id = @games.map do |game|
      game.game_id if game.season == season
    end.compact

    # 2. hash of team_id as keys and [goals, values] as values
    team_id_goals_shots = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
      # if game.game_id exists in our all_season_game_id array, then create key-value pair
      if all_season_game_id.include?(game.game_id)
        hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
      end
    end
    
    # 3. Calculate the average of goals/shots and assign to values
    avg_goals_made = team_id_goals_shots.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end

    # 4. Find max value and subsequent key to return the team_name with helper method team_list
    team_name = avg_goals_made.key(avg_goals_made.values.max)
    team_list[team_name]
  end

  def least_accurate_team(season)
    # 1. array of all game_id from a season
    all_season_game_id = @games.map do |game|
      game.game_id if game.season == season
    end.compact
    
    # 2. hash of team_id as keys and [goals, values] as values
    team_id_goals_shots = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
      # if game.game_id exists in our all_season_game_id array, then create key-value pair
      if all_season_game_id.include?(game.game_id)
        hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
      end
    end
    
    # 3. Calculate the average of goals/shots and assign to values
    avg_goals_made = team_id_goals_shots.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    
    # 4. Find min value and subsequent key to return the team_name with helper method team_list
    team_name = avg_goals_made.key(avg_goals_made.values.min)
    team_list[team_name]
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end