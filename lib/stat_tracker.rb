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

  def all_season_game_id(season)
    @games.map do |game|
      game.game_id if game.season == season
    end.compact 
  end 

  def winningest_coach(season)
    # we want the winning coach with the best win percentage in a season
    # output: string
    # 1. we will used games.csv and match the season with our input season, and return an array of all games in that season
    # 2. iterate over game_teams.csv using our created array in all_season_game_id as referance
    #       make a hash of our head coach as key and set values to [wins, total_games]
    # 3 transform_values on our created hash above and reset the value to wins/total games.round(4)
    # 4 after we have our array of keys being couch names and use .values to make value array, then .max array, then .keys(max_value) to get coach name

    coach_wins = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|

      if all_season_game_id(season).include?(game.game_id) 
        if game.result == "WIN"
          hash[game.head_coach] = [1 + hash[game.head_coach][0], 1 + hash[game.head_coach][1]]
        else
          hash[game.head_coach] = [hash[game.head_coach][0], 1 + hash[game.head_coach][1]]
        end
      end
    end

    require'pry';binding.pry
    coach_win_percentage = coach_wins.transform_values do |value|   # {coach => win percent .4423}
      (value[0] / value[1].to_f).round(4)
    end

    max_win_percentage = coach_win_percentage.values.max
    coach_win_percentage.key(max_win_percentage)
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end