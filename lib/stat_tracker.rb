require 'csv'
require_relative 'team'
require_relative 'game'
require_relative "game_team"
require_relative 'game_statable'

class StatTracker
include GameStatable

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

  def highest_scoring_home_team
    # @game_teams.csv
    # 1. find total amount of goals scored by each home team and keep track of the amount of games
    # hash {[team_id #] => [total goals, total games played by home team]}
    # 2. get hash.values.max
    # 3. ^find the correlary teamid
    # iterate thru @teams.csv & match hash.values.max to team_id # 
      # then output teamName

    # 1.
    total_goals = @game_teams.each_with_object({}) do |game, hash|
      # get the curr val for game.team_id or if doesn't exist: set it to [0,0]
      hash[game.team_id] = hash[game.team_id] || [0, 0]
      if game.hoa == "home"
        hash[game.team_id] = [game.goals + hash[game.team_id][0], hash[game.team_id][1] + 1]
      end
    end

    # 2.
    avg_goals = total_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    highest_avg_goals = avg_goals.values.max

    # 3. 
    highest_team_id = avg_goals.key(highest_avg_goals)

    # 4.
    @teams.each do |team| 
      return team.team_name if team.team_id == highest_team_id
    end
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end