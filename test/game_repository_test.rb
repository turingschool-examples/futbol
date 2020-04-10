require "minitest/autorun"
require "minitest/pride"
require "csv"
require "./lib/game_repository"

class GameRepositoryTest < Minitest::Test



  def test_it_exists
    game_repository = GameRepository.new('./data/games.csv')
    assert_instance_of GameRepository, game_repository
  end

  def test_it_has_attributes
    game_repository = GameRepository.new('./data/games.csv')

    assert_equal "20122013", game_repository.games_collection[0].season
  end

  def test_highest_total_score
    game_repository = GameRepository.new('./data/games.csv')

    assert_equal 11, game_repository.highest_total_score
  end

  def test_lowest_total_score
    game_repository = GameRepository.new('./data/games.csv')

    assert_equal 0 , game_repository.lowest_total_score

  end
end
