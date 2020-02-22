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
    team_file_path = './data/teams.csv'
    game_team_file_path = './test/fixtures/truncated_game_teams.csv'
    game_file_path = './test/fixtures/truncated_games.csv'
    @season_stat_coach = SeasonStatCoach.new(game_file_path, team_file_path, game_team_file_path)

    @team_info = {

      1 => {:team_name=> "Apples",
            :season_win_percent => 50.00,
            :postseason_win_percent => 70.00,
            :head_coach => "Jaughn"
          },
      2 => {:team_name=> "The Bunnies",
            :season_win_percent => 80.00,
            :postseason_win_percent => 15.00,
            :head_coach => "Rufus"
          },
      3 => {:team_name=> "Broncos",
            :season_win_percent => 60.00,
            :postseason_win_percent => 70.00,
            :head_coach => "Tim"
          },
      4 => {:team_name=> "Avalanche",
            :season_win_percent => 50.00,
            :postseason_win_percent => 25.00,
            :head_coach => "Aurora"
          },
      5 => {:team_name=> "John",
            :season_win_percent => 25.00,
            :postseason_win_percent => 0.0,
            :head_coach => "Megan"
            }
    }
    @season = mock('testseason')
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
