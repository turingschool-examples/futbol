require 'CSV'
require './lib/game'
require './lib/team'
require './lib/game_teams'

class StatTracker

  attr_reader :games, :game_details, :teams

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
      @game_teams_array = []
      CSV.foreach(locations[:game_teams], headers: true) do |row|
        @game_teams_array << GameTeam.new(row)
    end

      @games_array = []
      CSV.foreach(locations[:games], headers: true) do |row|
        @games_array << Game.new(row)
    end

      @teams_array = []
      CSV.foreach(locations[:teams], headers: true) do |row|
        @teams_array << Team.new(row)
    end
  end

    def count_of_teams
     @teams_array.size
    end

    def best_offense
      @game_teams_array.teams_sort_by_average_goal.last.team_name
    end

    def worst_offense
      @game_teams_array.teams_sort_by_average_goal.first.team_name
    end

    def team_average_goals(team_id)
      @game_teams_array.team_average_goals(team_id)
    end

    def highest_visitor_team
      @game_teams_array.highest_visitor_team
    end

    def highest_home_team
      @game_teams_array.highest_home_team
    end

    def lowest_visitor_team
      @game_teams_array.lowest_visitor_team
    end

    def lowest_home_team
      @game_teams_array.lowest_home_team
    end
end
