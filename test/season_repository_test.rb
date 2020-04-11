require './lib/season_repository'

season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')

def test_id_stats
  require 'pry'; binding.pry
end
