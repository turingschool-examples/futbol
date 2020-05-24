require 'csv'
# require 'games'
# require 'teams'
# require 'game_teams'
require 'pry'

class StatTracker

  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(paths)
    games_path = paths[:games]
    teams_path = paths[:teams]
    game_teams_path = paths[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end


end


#   def initialize
#     @games = Games.new(games_path)
#     @teams = Teams.new(teams_path)
#     @game_teams_path = GameTeams.new(game_teams_path)
#   end
#
# end

# def self.from_csv(path)
#   @games = CSV.read(path[:games])
#   @teams = CSV.read(path[:teams])
#   @game_teams = CSV.read(path[:game_teams])
# end
