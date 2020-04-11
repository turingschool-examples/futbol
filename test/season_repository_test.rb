require './lib/season_repository'

season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')

season_repository.winningst_coach("20122013")
season_repository.number_of_games("20122013", "John Tortorella")
