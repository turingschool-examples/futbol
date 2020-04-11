require './lib/stat_tracker'
require 'pry'

class SeasonStatistics
attr_reader :stat_tracker, :game_collection, :game_teams_collection, :teams_collection

  def initialize(game_collection, game_teams_collection, teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end

  def current_season_games(season)
    current_games = @game_collection.map do |game|
     if game.season == season
       game.game_id
     end
   end
   current_games.compact
  end

  def teams_hash
    teams = Hash.new(0)
    @teams_collection.each do |team|
      teams[team.id] = 0
    end
    teams
  end

  def coaches_hash
    coaches = Hash.new(0)
    @game_teams_collection.each do |team|
      coaches[head_coach] = 0
    end
    teams
  end

  def current_season_game_teams(season)

    current = @game_teams_collection.find_all do |game|
    current_season_games(season).include?(game.game_id)
    end
    
  end

  # def winningest_coach(season)
  #   current_season_game_teams(season).group_by do |game|
  #     game.head_coach
  #
  #
  #   coaches = coaches_hash
  #
  #     coaches[head_coach] += 1




end
