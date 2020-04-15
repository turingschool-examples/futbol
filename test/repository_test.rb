require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/league_repository'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/repository'

class RepositoryTest < Minitest::Test

  def test_it_exists
    repository = Repository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
  end
end
