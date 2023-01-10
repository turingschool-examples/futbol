
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class TeamRepo
  attr_reader :teams

  def initialize(locations)
    @teams = Team.read_file(locations[:teams])
  end
end