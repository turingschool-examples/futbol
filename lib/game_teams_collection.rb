require_relative './game_team'
require 'csv'

#GameTeamsCollection
class GameTeamsCollection

  attr_reader :path, :all_game_teams

  def initialize(path)
    @path = path
    @all_game_teams = []
    from_csv(path)
  end

  def from_csv(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |game_team_data|
      add_game_team(game_team_data)
    end
  end

  def add_game_team(data)
    @all_game_teams << GameTeam.new(data)
  end


end
