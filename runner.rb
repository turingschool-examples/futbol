require './lib/stat_tracker'

game_path = './data/games_dummy.csv'
team_path = './data/teams_dummy.csv'
game_teams_path = './data/game_teams_dummy.csv'

season_data = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(season_data)