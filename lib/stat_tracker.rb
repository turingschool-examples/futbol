require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'gameable'
require_relative 'leagueable'
require_relative 'teamable'
require_relative 'seasonable'
require_relative 'goalable'
require_relative 'leagueable_helper'
require_relative 'teamable_helper'
require_relative 'seasonable_helper'
require_relative 'goalable_helper'


class StatTracker
  include Gameable
  include Leagueable
  include Teamable
  include Seasonable
  include Goalable
  include LeagueableHelper
  include TeamableHelper
  include SeasonableHelper
  include GoalableHelper

  attr_reader :games, :teams, :game_teams

  def initialize
    @games = {} #hash with keys equal to game_id and values equal to Game objects
    @teams = {} #hash with keys equal to team_id and values equal to Team objects
    @game_teams = [] #array of hashes with values equal to GameTeams objects
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new

    # creates unique Game objects as hashes in @games instance variable
    CSV.foreach(locations[:games], headers: true) do |row|
      stat_tracker.games[row["game_id"].to_i] = Game.new(row)
    end

    # creates unique Team objects as hashes in @teams instance variable
    CSV.foreach(locations[:teams], headers: true) do |row|
      stat_tracker.teams[row["team_id"]] = Team.new(row)
    end

    # creates unique Game_Teams objects as hashes in @games_teams instance variable
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      stat_tracker.game_teams << GameTeam.new(row)
    end

    stat_tracker
  end

end
