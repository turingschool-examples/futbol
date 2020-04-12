require "minitest/autorun"
require "minitest/pride"
require "csv"
require "./lib/game_repository"

class GameRepositoryTest < Minitest::Test



  def test_it_exists
    game_repository = GameRepository.new('./data/games.csv')
    assert_instance_of GameRepository, game_repository
  end

  #we want to create tests for all the mehtods in game_repository here

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

  def test_percentage_home_wins
    game_repository = GameRepository.new('./data/games.csv')
    assert_equal 0.44, game_repository.percentage_home_wins
  end

  def test_percentage_visitor_wins
    game_repository = GameRepository.new('./data/games.csv')
    assert_equal 0.36, game_repository.percentage_visitor_wins
  end

  def test_percentage_ties
    game_repository = GameRepository.new('./data/games.csv')
    assert_equal 0.20, game_repository.percentage_ties
  end

  def test_average_goals_per_game
    game_repository = GameRepository.new('./data/games.csv')
    assert_equal 4.22, game_repository.average_goals_per_game
  end

end
