require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_teams'
require './lib/team'
require './lib/game'
require './lib/team_repository'
require './lib/season_repository'


class SeasonRepositoryTest < Minitest::Test
  # season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
  #
  # season_repository.winningst_coach("20122013")
  # season_repository.number_of_games("20122013", "John Tortorella")

  def test_most_tackles
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "FC Cincinnati", season_repository.most_tackles("20132014")
    assert_equal "Real Salt Lake", season_repository.most_tackles("20142015")
  end

  def test_fewest_tackles
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "New England Revolution", season_repository.fewest_tackles("20132014")
    assert_equal "Orlando City SC", season_repository.fewest_tackles("20142015")
  end

end
