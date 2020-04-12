require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_teams'
require './lib/team'
require './lib/game'
require './lib/team_repository'


class TeamRepositoryTest < Minitest::Test
  # require "./lib/team_repository"
#
# team_repository =TeamRepository.new('./data/teams.csv')
#move all Team Stats methods testing here
  def test_it_can_report_most_goals_scored
    game_repository = TeamRepository.new('./data/game_teams.csv', './data/teams.csv', './data/games.csv')
    assert_equal 4, game_repository.most_goals_scored("6")
  end

  def test_it_can_report_fewest_goals_scored
    game_repository = TeamRepository.new('./data/game_teams.csv', './data/teams.csv', './data/games.csv')
    assert_equal 1, game_repository.fewest_goals_scored("6")
  end

  def test_average_win_percentage
    team_repository = TeamRepository.new('./data/game_teams.csv', './data/teams.csv', './data/games.csv')
    assert_equal 0.17, team_repository.average_win_percentage(3)
  end

  def test_favorite_opponent
    team_repository = TeamRepository.new('./data/game_teams.csv', './data/teams.csv', './data/games.csv')
    assert_equal 0, team_repository.favorite_opponent(18)
  end

  def test_total_matches
    team_repository = TeamRepository.new('./data/game_teams.csv', './data/teams.csv', './data/games.csv')
    assert_equal 16 , team_repository.total_matches(3, 4)
  end

  def test_rival

  end
end
