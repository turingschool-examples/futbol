require_relative 'test_helper'
require './lib/season_stat'
require './lib/game_collection'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/game'
require './lib/game_team'
require './lib/team'

class SeasonStatTest < Minitest::Test
  def setup
    team_file_path = './data/teams.csv'
    game_file_path = './test/fixtures/truncated_games.csv'
    @game_collection = GameCollection.new(game_file_path)
    @team_collection = TeamCollection.new(team_file_path)
    @season_stat = SeasonStat.new(@game_collection, @team_collection)

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
      5 => {:team_name=> "Avalanche",
            :season_win_percent => 25.00,
            :postseason_win_percent => 0.0,
            :head_coach => "Megan"
            }
    }
    @season = mock('testseason')
  end

  def test_it_exists
    assert_instance_of SeasonStat, @season_stat
  end

  def test_it_can_get_all_seasons
    season_test_list = ["20122013", "20162017", "20142015", "20152016", "20132014"]

    assert_equal season_test_list, @season_stat.get_all_seasons
  end

  def test_it_can_get_season_games
    @season_stat.season_games_by_all_seasons
    @season_stat.get_all_seasons
    assert_instance_of Array, @season_stat.get_season_games("20122013")
    assert_equal 257, @season_stat.get_season_games("20122013").length
    assert_equal "20122013", @season_stat.get_season_games("20122013").first.season
  end

  def test_it_has_attributes
    @season_stat.season_games_by_all_seasons
    @season_stat.get_all_seasons
    assert_instance_of Array, @season_stat.get_season_games("20122013")
    assert_equal 257, @season_stat.get_season_games("20122013").length
    assert_instance_of Game, @season_stat.get_season_games("20122013").first
  end

  def test_it_can_count_season_games
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    assert_equal 257, @season_stat.count_of_season_games("20122013")
  end

  def test_it_can_get_average_goals_by_season
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    test_hash = {
            "20122013"=>4.04,
            "20162017"=>4.75,
            "20142015"=>3.75,
            "20152016"=>3.88,
            "20132014"=>4.33
                }
    assert_equal test_hash, @season_stat.average_goals_by_season
  end

  def test_it_can_get_season_games_by_type
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons
    assert_instance_of Array, @season_stat.games_by_type('Regular Season', "20122013")
    assert_equal 'Regular Season', @season_stat.games_by_type('Regular Season', "20122013").first.type
    assert_instance_of Array, @season_stat.games_by_type('Postseason', "20122013")
    assert_equal 'Postseason', @season_stat.games_by_type('Postseason', "20122013").first.type
    assert_equal [], @season_stat.games_by_type('Overtime', "20122013")
  end

  def test_it_get_team_data_by_team
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    assert_instance_of Hash, @season_stat.get_team_data("20122013")
    assert_equal 32, @season_stat.get_team_data("20122013").length
    assert_equal "1", @season_stat.get_team_data("20122013").keys.first
    assert_equal 'Atlanta United', @season_stat.get_team_data("20122013")["1"][:team_name]
  end

  def test_it_can_get_total_team_games_by_game_type
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    assert_equal 19, @season_stat.total_team_games_by_game_type(29, 'Regular Season', "20122013")
    assert_equal 15, @season_stat.total_team_games_by_game_type(17, 'Regular Season', "20122013")
    assert_equal 14, @season_stat.total_team_games_by_game_type(17, 'Postseason', "20122013")
  end

  def test_it_can_get_total_team_wins_by_game_type
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    assert_equal 4, @season_stat.total_team_wins_by_game_type(29, 'Regular Season', "20122013")
    assert_equal 7, @season_stat.total_team_wins_by_game_type(1, 'Regular Season', "20122013")
    assert_equal 0, @season_stat.total_team_wins_by_game_type(1, 'Postseason', "20122013")
    assert_equal 9, @season_stat.total_team_wins_by_game_type(17, 'Regular Season', "20122013")
    assert_equal 7, @season_stat.total_team_wins_by_game_type(17, 'Postseason', "20122013")
  end

  def test_it_can_calculate_team_win_percentage
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    assert_equal 21.05, @season_stat.team_win_percentage(29, 'Regular Season', "20122013")
    assert_equal 50.00, @season_stat.team_win_percentage(17, 'Postseason', "20122013")
    assert_equal 60.00, @season_stat.team_win_percentage(17, 'Regular Season', "20122013")
  end

  def test_it_can_calculate_biggest_bust
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    @season_stat.stubs(:get_team_data).returns(@team_info)
    assert_equal "The Bunnies", @season_stat.biggest_bust(@season)
  end

  def test_it_can_count_games_by_season
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    test_hash = {
      "20122013" => 257,
      "20162017" => 4,
      "20142015" => 16,
      "20152016" => 16,
      "20132014" => 6
    }
    assert_equal test_hash, @season_stat.count_of_games_by_season
  end

  def test_it_can_calculate_biggest_surprise
    @season_stat.get_all_seasons
    @season_stat.season_games_by_all_seasons

    @season_stat.stubs(:get_team_data).returns(@team_info)
    assert_equal "Apples", @season_stat.biggest_surprise(@season)
  end
end
