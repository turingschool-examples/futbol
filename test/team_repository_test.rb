require 'simplecov'
SimpleCov.start
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

  def test_team_info
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    expected = {"team_id"=>"18", "franchise_id"=>"34", "team_name"=>"Minnesota United FC", "abbreviation"=>"MIN", "link"=>"/api/v1/teams/18"}
    assert_equal expected, team_repository.team_info('18')
  end

  def test_best_season
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "20132014", team_repository.best_season("6")
  end

  def test_worst_season
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "20142015", team_repository.worst_season("6")
  end

  def test_games_per_season
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal 60, team_repository.games_per_season(3, "20122013")
  end

  def test_it_can_report_most_goals_scored
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal 6, team_repository.most_goals_scored("6")
  end

  def test_it_can_report_fewest_goals_scored
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal 0, team_repository.fewest_goals_scored("6")
  end

  def test_average_win_percentage
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal 0.49, team_repository.average_win_percentage("6")
  end

  def test_favorite_opponent
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "DC United", team_repository.favorite_opponent("18")
  end

  def test_total_matches
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal 33, team_repository.total_matches(3, 4)
  end

  def test_rival
    team_repository = TeamRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Houston Dash", team_repository.rival("18")
  end
end
