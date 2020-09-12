require_relative './game_team'

class GameTeamsManager
  attr_reader :game_teams, :tracker
  def initialize(game_teams_path, tracker)
    @game_teams = []
    @tracker = tracker
    create_games(game_teams_path)
  end

  def create_games(game_teams_path)
    game_teams_data = CSV.parse(File.read(game_teams_path), headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

end
