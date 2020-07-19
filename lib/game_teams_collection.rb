#GameTeamsCollection
class GameTeamsCollection
  attr_reader :path
  def initialize(path)
    @path = path
    @all_game_teams = []
  end
end
