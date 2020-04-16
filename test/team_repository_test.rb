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

  def test_team_info
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    expected = {"team_id"=>"18", "franchise_id"=>"34",
       "team_name"=>"Minnesota United FC", "abbreviation"=>"MIN",
       "link"=>"/api/v1/teams/18"}
    assert_equal expected, team_repository.team_info('18')
  end

  def test_best_season
    team_repository = TeamRepository.new('./data/games.csv',
       './data/game_teams.csv', './data/teams.csv')
    assert_equal "20132014", team_repository.best_season("6")
  end

  def test_worst_season
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal "20142015", team_repository.worst_season("6")
  end

  def test_games_per_season
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal 60, team_repository.games_per_season(3, "20122013")
  end

  def test_it_can_report_most_goals_scored
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal 6, team_repository.most_goals_scored("6")
  end

  def test_it_can_report_fewest_goals_scored
    team_repository = TeamRepository.new('./data/games.csv',
       './data/game_teams.csv', './data/teams.csv')
    assert_equal 0, team_repository.fewest_goals_scored("6")
  end

  def test_average_win_percentage
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal 0.49, team_repository.average_win_percentage("6")
  end

  def test_favorite_opponent
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal "DC United", team_repository.favorite_opponent("18")
  end

  def test_total_matches
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal 33, team_repository.total_matches(3, 4)
  end

  def test_rival
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    assert_equal "Houston Dash", team_repository.rival("18")
  end

  def test_generate_opponent_hash
    team_repository = TeamRepository.new('./data/games.csv',
      './data/game_teams.csv', './data/teams.csv')
    expected = {19=>0.45833333333333337, 16=>0.4333333333333333,
      28=>0.4893617021276593, 24=>0.3611111111111112, 20=>0.6153846153846152,
      29=>0.6153846153846154, 30=>0.33333333333333337, 21=>0.6666666666666669,
      10=>0.4, 13=>0.7999999999999999, 52=>0.3333333333333333,
      3=>0.4666666666666666, 27=>0.5, 1=>0.30000000000000004, 8=>0.6,
      18=>0.44444444444444453, 7=>0.4, 23=>0.4999999999999999,
      15=>0.30000000000000004, 53=>0.2777777777777778, 12=>0.6, 14=>0.4, 4=>0.5,
      6=>0.4, 17=>0.38461538461538464, 22=>0.5769230769230768,
      2=>0.6, 25=>0.3, 5=>0.30000000000000004, 9=>0.2, 54=>0.25}
    assert_equal expected, team_repository.generate_opponent_hash(26)
  end
end
