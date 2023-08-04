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
    all_season_game_id = @games.map do |game|
      game.game_id if game.season == season
    end.compact

    team_id_goals_shots = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
      if all_season_game_id.include?(game.game_id)
        hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
      end
    end
    
    avg_goals_made = team_id_goals_shots.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end

    team_name = avg_goals_made.key(avg_goals_made.values.max)
    team_list[team_name]
  end

  def least_accurate_team(season)
    all_season_game_id = @games.map do |game|
      game.game_id if game.season == season
    end.compact
    
    team_id_goals_shots = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
      if all_season_game_id.include?(game.game_id)
        hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
      end
    end
    
    avg_goals_made = team_id_goals_shots.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    
    team_name = avg_goals_made.key(avg_goals_made.values.min)
    team_list[team_name]
  end
  
  def all_season_game_id(season)
    @games.map do |game|
      game.game_id if game.season == season
    end.compact 
  end 

  def total_tackles_by_team_id(season)
    @game_teams.each_with_object(Hash.new(0)) do |game, hash|
      if all_season_game_id(season).include?(game.game_id)
        hash[game.team_id] += game.tackles.to_i
      end
    end
  end

  def most_tackles(season)
    team_with_most_tackles = total_tackles_by_team_id(season).values.max
    most_tackles = total_tackles_by_team_id(season).key(team_with_most_tackles)
    team_list[most_tackles]
  end

  def fewest_tackles(season)
    team_with_fewest_tackles = total_tackles_by_team_id(season).values.min
    fewest_tackles = total_tackles_by_team_id(season).key(team_with_fewest_tackles)
    team_list[fewest_tackles]
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end