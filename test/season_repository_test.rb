require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_teams'
require './lib/team'
require './lib/game'
require './lib/team_repository'
require './lib/season_repository'

class SeasonRepositoryTest < Minitest::Test

  def test_winningest_coach
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Claude Julien", season_repository.winningest_coach("20132014")
    assert_equal "Alain Vigneault", season_repository.winningest_coach("20142015")
  end

  def test_worst_coach
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Peter Laviolette", season_repository.worst_coach("20132014")
  end

  def test_most_accurate_team
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Real Salt Lake", season_repository.most_accurate_team("20132014")
    assert_equal "Toronto FC", season_repository.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "New York City FC", season_repository.least_accurate_team("20132014")
  end

  def test_most_tackles
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "FC Cincinnati", season_repository.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_fewest_tackles
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Atlanta United", season_repository.fewest_tackles("20132014")
    assert_equal "Orlando City SC", season_repository.fewest_tackles("20142015")
  end
end
