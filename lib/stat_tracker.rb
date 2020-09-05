require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @games = {}
    CSV.foreach(locations[:games], headers: true) do |row|
      @games["game_data"] = Game.new({game_id: row["game_id"], season: row["season"], type: row["type"], date_time: row["date_time"], away_team_id: row["away_team_id"], home_team_id: row["home_team_id"], away_goals: row["away_goals"], home_goals: row["home_goals"], venue: row["venue"], venue_link: row["venue_link"]})
    end
    # @games = CSV.read(locations[:games], headers: true)
    # @teams = {}
    # CSV.foreach(locations[:teams], headers: true) do |row|
    #   @teams["teams_data"] = Team.new
    # end

    # @game_teams = CSV.read(locations[:game_teams])
    end
  end

  # def from_csv(locations)
  #   @games = CSV.read(locations[:games])
  #   @teams = CSV.read(locations[:teams])
  #   @game_teams = CSV.read(locations[:game_teams])
  # end

# end
