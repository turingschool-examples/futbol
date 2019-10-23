require './lib/game_collection'
require './lib/teams_collection'
require './lib/game_teams_collection'

class StatTracker

  def self.from_csv(locations)
    game_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, teams_path, game_teams_path)
  end

  def initialize(game_path, teams_path, game_teams_path)
    @game_path = game_path
    @teams_path = teams_path
    @game_teams_path = game_teams_path
  end

  def games
    GameCollection.new(@game_path)
  end

  # def teams(@teams)
  #   TeamCollection.new(@team_path)
  # end
  #
  # def game_teams(@game_teams)
  #   GameTeamsCollection.new(@game_teams_path)
  # end
end