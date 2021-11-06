require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './stat_tracker.rb'
class League
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data)
    @games = data[:games]
    @teams = data[:teams]
    @game_teams = data[:game_teams]
    require "pry"; binding.pry
  end

  def count_of_teams
    @teams.count
  end

end
