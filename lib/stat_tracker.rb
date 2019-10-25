require_relative './game_collection'

class StatTracker
  attr_reader :stats

  def initialize(game_path, team_path, game_team_path)
    # should we move the creation of instances into a method
    @games_collection = GameCollection.new(game_path)
    @teams_collection = TeamCollection.new(team_path, game_team_path)
    #game_teams_path = GameTeamsCollection.new(team_path)

  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_team_path = locations[:game_teams]

    self.new(game_path, team_path, game_team_path)
  end
  #
  # def games
  #   @games_collection = GameCollection.new(@game_path)
  #   #in game collection is where we would make new game instances
  # end
  # def teams
  #   TeamCollection.new(@team_path)
  # end
  #
  # def game_teams
  #   GameTeamCollection.new(@game_team_path)
  # end

  def highest_total_score
    @games_collection.highest_total_score
  end
end
