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

  #array off all gameteam objects played in that season
  #can't get from just @games because doesn't have tackles so need to relate
  #season_id to game id then game_id in gameteams data to game_id there
  #this can definitely be refactored
  def games_played_in_season(season)
    game_objects_by_season = @games.group_by do |game|
      game.season
    end
    get_games_in_season = game_objects_by_season.keep_if do |key, value|
      key == season
    end
    season_game_ids = get_games_in_season.flat_map do |season, games|
      games.flat_map {|game| game.game_id}
    end
    @game_teams.find_all {|games| season_game_ids.include?(games.game_id)}
  end
  #Hash of total team tackles by team_id based ion the previous helper method of\
  #games_played_in_season
  def total_tackles_by_team_id(season)
    games_played_in_season(season).each_with_object(Hash.new(0)) do |gameteam, hash|
      hash[gameteam.team_id] += gameteam.tackles.to_i
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