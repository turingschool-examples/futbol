require 'csv'

class GameTeamManager
  attr_reader :game_teams,
              :tracker
  def initialize(path, tracker)
    @game_teams = []
    create_underscore_game_teams(path)
    @tracker = tracker
  end

  def create_underscore_game_teams(path)
    game_teams_data = CSV.read(path, headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end
end
