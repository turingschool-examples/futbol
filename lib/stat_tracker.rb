require './lib/game_collection'

class StatTracker

  attr_reader :game_path, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_path = game_path,
    @team_path = team_path,
    @game_team_path = game_team_path
  end

  def self.from_csv(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_team_path = locations[:game_teams]

    StatTracker.new(@game_path, @team_path, @game_team_path)
  end

  def game_collection
    GameCollection.new(@game_path)
  end

end
