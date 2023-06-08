require './lib/stat_tracker'
require './lib/game_statics'
game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
    games: game_path,
    teams: team_path,
    game_by_team: game_teams_path
}
stat_tracker = StatTracker.new
stat_tracker.from_csv(locations)

game_statistics = GameStatics.new(stat_tracker.games)
game_statistics.percentage_ties
game_statistics.count_of_games_by_season