require_relative 'test_helper'
require './lib/scored_goal_stat'
require './lib/team_collection'
require './lib/game_team_collection'
require './lib/game_collection'

class ScoredGoalStatTest < Minitest::Test

  def setup
    team_file_path = './data/teams.csv'
    game_team_file_path = './test/fixtures/truncated_game_teams.csv'
    game_file_path = './test/fixtures/truncated_games.csv'
    @team_collection = TeamCollection.new(team_file_path)
    @game_team_collection = GameTeamCollection.new(game_team_file_path)
    @game_collection = GameCollection.new(game_file_path)
    @scored_goal_stat = ScoredGoalStat.new(@team_collection, @game_team_collection, @game_collection)
  end

  def test_it_exists
    assert_instance_of ScoredGoalStat, @scored_goal_stat
  end

  def test_it_can_return_most_goals_scored
    assert_equal 5, @scored_goal_stat.most_goals_scored("3")
  end

  def test_it_can_return_fewest_goals_scored
    assert_equal 0, @scored_goal_stat.fewest_goals_scored("3")
  end

  def test_it_can_return_total_goals
    assert_instance_of Array, @scored_goal_stat.total_goals_scored("3")
    assert_equal 28, @scored_goal_stat.total_goals_scored("3").length
    assert_equal 2, @scored_goal_stat.total_goals_scored("3").first
  end

  def test_it_can_return_biggest_team_blowout
    assert_equal 4, @scored_goal_stat.biggest_team_blowout("3")
  end

  def test_it_can_return_worst_loss
    assert_equal 3, @scored_goal_stat.worst_loss("3")
  end

  def test_it_can_calculate_win_or_loss
    assert_instance_of Integer, @scored_goal_stat.win_loss_logic("3", true)
    assert_equal 4, @scored_goal_stat.win_loss_logic("3", true)
    assert_equal 3, @scored_goal_stat.win_loss_logic("3", false)
  end

  def test_it_can_return_favorite_opponent
    assert_equal "North Carolina Courage", @scored_goal_stat.favorite_opponent("3")
  end

  def test_it_can_return_rival
    assert_equal "Portland Thorns FC", @scored_goal_stat.rival("3")
  end

  def test_it_can_return_oppoonent_games
    assert_instance_of Hash, @scored_goal_stat.opponent_games("3")
    assert_equal 12, @scored_goal_stat.opponent_games("3").length
    assert_equal ["2012020714", "2012020128"], @scored_goal_stat.opponent_games("3")["1"]
  end

  def test_it_can_return_lost_team_games
    assert_instance_of Hash, @scored_goal_stat.given_team_games_lost("3")
    assert_equal 9, @scored_goal_stat.given_team_games_lost("3").length
    assert_equal ["2014030312", "2014030313", "2014030315"], @scored_goal_stat.given_team_games_lost("3")["14"]
  end

  def test_it_can_create_list_of_opponent_games
    assert_instance_of Hash, @scored_goal_stat.create_list_opponent_games("3", true)
    assert_equal 9, @scored_goal_stat.create_list_opponent_games("3", true).length
    assert_equal ["2014030312", "2014030313", "2014030315"], @scored_goal_stat.create_list_opponent_games("3", true)["14"]
    assert_equal 12, @scored_goal_stat.create_list_opponent_games("3", false).length
    assert_equal ["2012020714", "2012020128"], @scored_goal_stat.create_list_opponent_games("3", false)["1"]
  end

  def test_it_can_return_total_opponent_games
    assert_instance_of Hash, @scored_goal_stat.total_opponent_games("3")
    assert_equal [1, 1, 2, 1, 2, 1, 11, 2, 1, 5, 7, 5], @scored_goal_stat.total_opponent_games("3").values
    assert_equal 11, @scored_goal_stat.total_opponent_games("3")["5"]
    assert_equal 2, @scored_goal_stat.total_opponent_games("3")["7"]
  end

  def test_it_can_return_total_team_losses
    assert_instance_of Hash, @scored_goal_stat.total_given_team_losses("3")
    assert_equal 9, @scored_goal_stat.total_given_team_losses("3").length
    assert_equal ["52", "9", "1", "8", "4", "6", "15", "5", "14"], @scored_goal_stat.total_given_team_losses("3").keys
    assert_equal 1, @scored_goal_stat.total_given_team_losses("3")["4"]
    assert_equal 1, @scored_goal_stat.total_given_team_losses("3")["52"]
  end

  def test_it_can_return_average_opponent_games
    assert_instance_of Hash, @scored_goal_stat.average_opponent_games("3")
    assert_equal 71.42857142857143, @scored_goal_stat.average_opponent_games("3")["15"]
    assert_equal 100.0, @scored_goal_stat.average_opponent_games("3")["8"]
  end

  def test_it_can_retrieve_team_name
    assert_instance_of String, @scored_goal_stat.retrieve_team_name("3")
    assert_equal "Houston Dynamo", @scored_goal_stat.retrieve_team_name("3")
    assert_equal "New York Red Bulls", @scored_goal_stat.retrieve_team_name("8")
  end
end
