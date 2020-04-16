require './test/test_helper'
require './lib/stat_tracker'
require './lib/season_statistics'
require './lib/statistics'
require 'mocha/minitest'
require 'pry'

class SeasonStatisticsTest < Minitest::Test

  def setup
  game_path = './data/games_fixture.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams_fixture.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
  @stat_tracker = StatTracker.from_csv(locations)
  @season_statistics = @stat_tracker.season_statistics
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_has_readable_attributes
    assert_equal "2012030221", @season_statistics.game_collection[0].game_id

    assert_instance_of Array, @season_statistics.game_collection
    assert_instance_of Array, @season_statistics.game_teams_collection
    assert_instance_of Array, @season_statistics.teams_collection

    assert_equal "2012030221", @season_statistics.game_collection[0].game_id
    assert_equal "2014030326", @season_statistics.game_collection[-1].game_id

    assert_equal "2012030221", @season_statistics.game_teams_collection[0].game_id
    assert_equal "2012030124", @season_statistics.game_teams_collection[-1].game_id

    assert_equal "1", @season_statistics.teams_collection[0].id
    assert_equal "53", @season_statistics.teams_collection[-1].id
  end

  def test_current_season_game_ids
    assert_equal ["2013020674", "2013020177", "2013021085"] , @season_statistics.current_season_game_ids("20132014")
  end

  def test_current_season_game_teams
    game1 = @season_statistics.game_collection[1].game_id
    game2 = @season_statistics.game_collection[2].game_id
    @season_statistics.stubs(:current_season_game_ids).returns([game1, game2])
    assert_instance_of GameTeam, @season_statistics.current_season_game_teams("20122013").first
    assert_equal [@season_statistics.game_teams_collection[2], @season_statistics.game_teams_collection[3], @season_statistics.game_teams_collection[4], @season_statistics.game_teams_collection[5]], @season_statistics.current_season_game_teams("20122013")
  end

  def test_team_ids
    game_t = @season_statistics.game_teams_collection[1..4]
    @season_statistics.stubs(:current_season_game_teams).returns(game_t)
    assert_equal ["6", "3", "6", "6"], @season_statistics.team_ids("20132014")
    assert_instance_of Array, @season_statistics.team_ids("20132014")
  end

  def test_team_ids_hash
    @season_statistics.stubs(:team_ids).returns("2012030222", "2012030223", "2012030224", "2012030225")
    assert_equal ({"1"=>0, "3"=>0, "30"=>0, "2"=>0, "20"=>0, "12"=>0, "22"=>0}), @season_statistics.team_ids_hash("20132013")
  end

  def test_name_hash
    assert_equal "Atlanta United", @season_statistics.team_name_hash["1"]
    assert_equal "Seattle Sounders FC", @season_statistics.team_name_hash["2"]
  end

  def test_coach_names
    names = @season_statistics.game_teams_collection[1..4]
    @season_statistics.stubs(:current_season_game_teams).returns(names)
    assert_equal ["Claude Julien", "John Tortorella", "Claude Julien", "Claude Julien"], @season_statistics.coach_names("20132014")
  end

  def test_coaches_hash
    names = @season_statistics.game_teams_collection[1..4]
    @season_statistics.stubs(:current_season_game_teams).returns(names)
    assert_equal ({"Claude Julien" => 0, "John Tortorella" => 0}), @season_statistics.coaches_hash("20132014")
  end

  def test_high_low_key_return
    assert_equal "6", @season_statistics.high_low_key_return({"6"=>139, "3"=>154},:low)
    assert_equal "3", @season_statistics.high_low_key_return({"6"=>139, "3"=>154},:high)
  end

  def test_team_tackles_hash
    names = @season_statistics.game_teams_collection[1..4]
    @season_statistics.stubs(:current_season_game_teams).returns(names)
    assert_equal ({"6" => 115, "3" => 33}), @season_statistics.team_tackles_hash("20132014")
    assert_instance_of Hash, @season_statistics.team_tackles_hash("20132014")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @season_statistics.coach_win_loss_results("20122013", :high)
  end

  def test_losingest_coach
    assert_equal "John Tortorella", @season_statistics.coach_win_loss_results("20122013", :low)
  end

  def test_most_least_tackles
    assert_equal "Houston Dynamo", @season_statistics.most_least_tackles("20122013", :high)
    assert_equal "FC Dallas", @season_statistics.most_least_tackles("20122013", :low)
  end

  def test_most_accurate_team
    assert_equal "FC Dallas", @season_statistics.team_accuracy("20122013", :high)
  end

  def test_least_accurate_team
    assert_equal "Houston Dynamo", @season_statistics.team_accuracy("20122013",:low)
  end
end
