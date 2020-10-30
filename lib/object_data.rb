 
class ObjectData
  attr_reader :games, :teams, :game_teams
  def initialize(stat_tracker)
    @games = stat_tracker.retrieve_games
    @teams = stat_tracker.retrieve_teams
    @game_teams = stat_tracker.retrieve_game_teams
  end
end
