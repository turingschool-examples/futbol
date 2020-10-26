require './lib/game_team'

class GameTeamsCollection
  attr_reader :game_teams
  def initialize(file_path)
    @game_teams = []
    create_game_teams(file_path)
  end

  def create_game_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << GameTeam.new(row)
    end
  end
end
