require 'csv'
require './lib/game_teams'
require './lib/stat_tracker'
require './lib/game_teams_collection'
require_relative 'test_helper'

class GameTeamsCollectionTest < MiniTest::Test
  def test_it_exists
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_instance_of GameTeamsCollection, new_game_tracker_instance
  end

  def test_it_initializes
    tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal './dummy_data/dummy_game_teams.csv', tracker_instance.game_teams_path
    assert_equal 15, tracker_instance.game_teams_collection_instances.size
  end

  def test_winningest_team
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal "3", new_game_tracker_instance.winningest_team_id
  end

  def test_all_game_teams
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal 3 , new_game_tracker_instance.all_game_teams.first.team_id
  end

  def test_team_id_maker
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal [3, 6, 12, 30, 26, 29, 5], new_game_tracker_instance.team_id_maker
  end

  def test_team_stat_maker
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    expected = [3, {:away_wins=>0, :away_losses=>2, :home_wins=>0, :home_losses=>2, :all_ties=>0}]
    assert_equal expected, new_game_tracker_instance.team_stat_maker.first
  end

  def test_team_id_maker
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal [3, 6, 12, 30, 26, 29, 5], new_game_tracker_instance.team_id_maker
  end

  def test_game_stat_maker
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    expected = {:away_wins=>1, :away_losses=>0, :home_wins=>0, :home_losses=>1, :all_ties=>0}
    assert_equal expected, new_game_tracker_instance.game_stat_maker(5)
  end

  def test_worst_fans
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal [5], new_game_tracker_instance.worst_fans
  end

  def test_most_goals_scored
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal 2, new_game_tracker_instance.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    new_game_tracker_instance = GameTeamsCollection.new('./dummy_data/dummy_game_teams.csv')
    assert_equal 1, new_game_tracker_instance.fewest_goals_scored("3")
  end
end
