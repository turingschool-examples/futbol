
require_relative './stat_tracker.rb'
class League
  attr_reader :games,
              :teams,
              :game_teams
  def initialize(data)
    #require "pry"; binding.pry
    @games = data[:games]
    @teams = data[:teams]
    @game_teams = data[:game_teams]
    # @games = CSV.parse(File.read(locations[:games]), headers: true).map {|row| Game.new(row)}
    # @teams = CSV.parse(File.read(locations[:teams]), headers: true).map {|row| Team.new(row)}
    # @game_teams = CSV.parse(File.read(locations[:game_teams]), headers: true).map {|row| GameTeam.new(row)}

    require "pry"; binding.pry
  end

  def count_of_teams
        @teams.count
  end

end
