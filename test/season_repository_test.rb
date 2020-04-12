require './lib/season_repository'
require 'minitest/autorun'
require 'minitest/pride'



class SeasonRepositoryTest < Minitest::Test

  def test_winningest_coach
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Claude Julien", season_repository.winningst_coach("20132014")
  end

  def test_worst_coach
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Peter Laviolette", season_repository.worst_coach("20132014")
  end
end
