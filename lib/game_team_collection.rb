require_relative 'loadable'
require_relative 'game_teams'

class GameTeamCollection
  include Loadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
    # eventually the class name GameTeams
    # will need to be SINGULAR
  end

end
