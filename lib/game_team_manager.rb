require 'game_team'

class GameTeamManager
  attr_reader :game_teams

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
  end
end
