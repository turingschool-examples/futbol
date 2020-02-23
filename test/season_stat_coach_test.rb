require_relative 'test_helper'
require './lib/season_stat'
require './lib/game_collection'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/game'
require './lib/game_team'
require './lib/team'
require './lib/season_stat_coach'


class SeasonStatCoachTest < Minitest::Test
  def setup
    game_team_file_path = './test/fixtures/truncated_game_teams.csv'
    @season_stat_coach = SeasonStatCoach.new(game_team_file_path)
  end

  def test_it_exists
    assert_instance_of SeasonStatCoach, @season_stat_coach
  end

  def test_it_can_get_game_teams_by_season
    assert_instance_of Array, @season_stat_coach.get_season_game_teams("20122013")
    assert_equal 117, @season_stat_coach.get_season_game_teams("20122013").length
    assert_instance_of GameTeam, @season_stat_coach.get_season_game_teams("20122013").first
  end

  def test_it_can_get_coaches_by_season
    assert_instance_of Array, @season_stat_coach.coaches_by_season("20122013")
    assert_equal "Claude Julien", @season_stat_coach.coaches_by_season("20122013")[1]
    assert_equal 14, @season_stat_coach.coaches_by_season("20122013").length
    assert_nil @season_stat_coach.coaches_by_season("20122013")[29]
  end

  def test_it_can_get_coach_wins_by_season
    assert_equal 2, @season_stat_coach.get_coach_wins_by_season("John Tortorella", "20122013")
  end

  def test_it_can_get_all_coach_games_by_season
    assert_equal 12, @season_stat_coach.get_total_coach_games_by_season("John Tortorella", "20122013")
  end

  def test_it_can_get_coach_win_percentage_by_season
    assert_equal 16.67, @season_stat_coach.coach_win_percentage_by_season("John Tortorella", "20122013")
  end

  def test_it_can_create_coaches_hash
    assert_instance_of Hash, @season_stat_coach.create_coach_win_data_by_season("20122013")
    assert_equal 16.67, @season_stat_coach.create_coach_win_data_by_season("20122013")["John Tortorella"]
  end

  def test_it_can_find_winningest_coach
    assert_equal "Claude Julien", @season_stat_coach.winningest_coach("20122013")
  end
end
