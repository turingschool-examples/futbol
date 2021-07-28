require './lib/game'
require './lib/team'
require './lib/game_team'
require 'csv'
require 'pry'


class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = Game.read_file(locations[:games])
    @teams = Team.read_file(locations[:teams])
    @game_teams = GameTeam.read_file(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end

#
# locations.each do |class_type, path|
#   rows = CSV.read(path, headers: true, header_converters: :symbol)
#   class_name = class_type.capitalize
#   binding.pry
#   rows.map do |row|
#
# @games = from_csv(games_path, Game) # Maybe ||= could prevent edge cases by assigning
# @teams = from_csv(teams_path, Team) # from the .csv if @games does not yet exist
# @game_teams = from_csv(game_teams_path, GameTeam)
#
#
#   def self.from_csv(stat_tracker_params)
#     StatTracker.new(stat_tracker_params)
#
# my examples
# stat_tracker = StatTracker.get_csv(locations)
# # require "pry"; binding.pry
# # p stat_tracker.find_team_by_id('3')
# # p stat_tracker.games_by_season
# p stat_tracker.total_game_score_array
#
#   def find_team_by_id(id) # test method - feel free to delete
#     @teams.find do |team|
#       team.team_id == id
#     end
#   end
#
#   def games_by_season # test method - feel free to delete
#     @games.group_by { |game| game.season }
#   end
#
#   def total_game_score_array # test method - I'm not even sure this one's in the method list
#   total_game_scores = []
#   @games.each do |game|
#     total_game_scores << game.total_game_score #using a method from game class
#   end
#   total_game_scores
#   end
# end
#
# maybe put all the stuff below in another file? module? idk
