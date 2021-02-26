require_relative 'game_team'
require_relative 'data_loadable'

class GameTeamManager

  attr_reader :game_teams
  include DataLoadable

  def initialize(data)
    @game_teams = load_data(data, GameTeam)
  end
end
