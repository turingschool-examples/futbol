require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'gameable'
require_relative 'leagueable'
require_relative 'teamable'
require_relative 'seasonable'

class StatTracker
  include Gameable
  include Leagueable
  include Teamable
  include Seasonable

  attr_reader :games, :teams, :game_teams

  def initialize
    @games = [] #array of hashes with values equal to Game objects
    @teams = [] #array of hashes with values equal to Team objects
    @game_teams = [] #array of hashes with values equal to GameTeams objects
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new

    # creates unique Game objects as hashes in @games instance variable
    CSV.foreach(locations[:games], headers: true) do |row|
      stat_tracker.games << {row.fetch("game_id") => Game.new(row.fetch("game_id"),
                                                      row.fetch("season"),
                                                      row.fetch("type"),
                                                      row.fetch("date_time"),
                                                      row.fetch("away_team_id"),
                                                      row.fetch("home_team_id"),
                                                      row.fetch("away_goals").to_i,
                                                      row.fetch("home_goals").to_i,
                                                      row.fetch("venue"),
                                                      row.fetch("venue_link")
                                                      ) }
    end

    # creates unique Team objects as hashes in @teams instance variable
    CSV.foreach(locations[:teams], headers: true) do |row|
      stat_tracker.teams << {row.fetch("team_id") => Team.new(row.fetch("team_id"),
                                                      row.fetch("franchiseId"),
                                                      row.fetch("teamName"),
                                                      row.fetch("abbreviation"),
                                                      row.fetch("Stadium"),
                                                      row.fetch("link")
                                                      ) }
    end

    # creates unique Game_Teams objects as hashes in @games_teams instance variable
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      stat_tracker.game_teams << {row.fetch("game_id") => GameTeam.new(row.fetch("game_id"),
                                                      row.fetch("team_id"),
                                                      row.fetch("HoA"),
                                                      row.fetch("result"),
                                                      row.fetch("settled_in"),
                                                      row.fetch("head_coach"),
                                                      row.fetch("goals").to_i,
                                                      row.fetch("shots").to_i,
                                                      row.fetch("tackles").to_i,
                                                      row.fetch("pim").to_i,
                                                      row.fetch("powerPlayOpportunities").to_i,
                                                      row.fetch("powerPlayGoals").to_i,
                                                      row.fetch("faceOffWinPercentage").to_f,
                                                      row.fetch("giveaways").to_i,
                                                      row.fetch("takeaways").to_i
                                                      ) }
    end

    stat_tracker

  end

end
