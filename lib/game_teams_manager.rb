require './lib/game_teams'



class GameTeamsManager
  attr_reader :game_teams_hash

def initialize(game_teams_path)
  @game_teams_path = game_teams_path
  @game_teams_hash = {} ######## can easily modify to array
  CSV.foreach(game_teams_path, headers: true) do |row|
    game_teams_hash[row[0]] = GameTeam.new(row)
  end
end



end
