require './lib/game'
require './lib/team'
require './lib/game_team'

module ObjectGenerator

  def games_array_creator(path)
    games_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def teams_array_creator(path)
    teams_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def game_teams_array_creator(path)
    game_teams_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end
end
