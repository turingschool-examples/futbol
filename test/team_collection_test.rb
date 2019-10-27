require './test/test_helper'
require './lib/team_collection'

class TeamsCollectionTest < Minitest::Test

  def setup
    @total_teams = TeamCollection.new("./data/teams_sample.csv", "./data/game_teams_sample.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @total_teams
  end

  # def test_it_has_total_teams
  #   @total_teams.create_teams("./test/data/teams_sample.csv")
  #   assert_equal 8, @total_teams.total_teams.length
  # end
  #
  # def test_it_has_count_of_teams
  #   assert_equal 8, @total_teams.count_of_teams
  # end
  #
  # def test_it_has_the_best_offense
  #   assert_equal "New York City FC", @total_teams.best_offense
  # end
  #
  # def test_it_has_the_worst_offense
  #   assert_equal "Sporting Kansas City", @total_teams.worst_offense
  # end
  #
  # def test_it_has_the_best_defense
  #   assert_equal "FC Dallas", @total_teams.best_defense
  # end
  #
  # def test_it_has_the_worst_defense
  #   assert_equal "Houston Dynamo", @total_teams.worst_defense
  # end
  #
  # def test_it_has_winningest_team
  #   # FC Dallas has only wins
  #   assert_equal "FC Dallas", @total_teams.winningest_team
  # end
  #
  # def test_it_has_best_fans
  #   assert_equal "LA Galaxy", @total_teams.best_fans
  # end
  #
  def test_it_has_worst_fans
    #need to include more data so we an actually get a list of the worst teams?
    assert_equal [], @total_teams.worst_fans
  end

  # def test_it_has_highest_scoring_visitor
  #   assert_equal "Houston Dynamo", @total_teams.highest_scoring_visitor
  # end

  def test_it_can_group_by_away_team_id_and_goals
    away_group = [[3, 2], [6, 3], [3, 2], [6, 3], [6, 2], [3, 1], [6, 3], [3, 2], [3, 1]]
    assert_equal away_group, @total_teams.group_by_away_team_id_and_goals
  end

  def test_sum_of_away_games
    away_game_sum = {3=>8, 6=>11}
    assert_equal away_game_sum, @total_teams.sum_of_away_games
  end

  def test_grouping_away_test
    assert_equal 4, @total_teams.group_away_goals
  end

end
