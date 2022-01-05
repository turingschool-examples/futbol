require 'csv'
require './lib/game'
require './lib/team'
require './lib/team_tracker'
require './lib/game_tracker'

class LeagueTracker
  attr_reader :teams, :games, :contents

  def initialize(path, path_2 = nil)
    @contents = CSV.open "#{path_2}", headers:true, header_converters: :symbol
    team_tracker = TeamTracker.new
    game_tracker = GameTracker.new(path)
    @teams = team_tracker.teams
    @games = game_tracker.games
  end

  def count_of_teams
    @teams.uniq.count
  end

  def best_offense
    accumulator = {}
    @contents.each do |row|
      accumulator[row[:team_id]] += row[:goals]
    end
  end



end
