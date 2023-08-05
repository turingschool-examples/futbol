# require 'csv'
require_relative 'team'
require_relative 'game'
require_relative "game_team"
require_relative 'game_statable'
require_relative 'league_statable'
require_relative 'season_statable'
require_relative 'data_parsable'

class StatTracker
include DataParsable
include GameStatable
include LeagueStatable
include SeasonStatable
  
  # def win_list_per_team(team_id)
  #   win_list = []
  #   @game_teams.each do |game|
  #     if team_id == team_id && game.result == "WIN"
  #       win_list << game.game_id
  #     end
  #   end
  #   win_list
  # end

  # def best_season(team_id)
  #   win_list_per_team(team_id).each do |game_id|
  #     @games.each do |game| 

  #     end
  #   end
  # end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end