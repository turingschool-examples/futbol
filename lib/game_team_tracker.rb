class GameTeamTracker < Statistics
  def count_of_teams
    unique = @game_teams.map {|game|game.team_id}
    unique.uniq.count
  end
end
# game_path = './data/game_teams_stub.csv'
# locations = {
#   games: './data/games_stub.csv',
#   game_teams: game_path}
# game_tracker = GameTeamTracker.new(locations)
# p game_tracker.
