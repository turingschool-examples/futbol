require 'csv'
require './lib/stat_tracker'
require './lib/game_team'

class GameTeamsManager

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams = []
    create_game_teams(path)
  end

  def create_game_teams(path)
    @game_teams = path.map do |data|
      GameTeam.new(data, self)
    end
  end

end
