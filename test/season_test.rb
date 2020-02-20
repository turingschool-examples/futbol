require_relative 'test_helper'
require './lib/season'
require './lib/game_collection'
require './lib/game_team_collection'
require './lib/team_collection'
require './lib/game'
require './lib/game_team'
require './lib/team'

class SeasonTest < Minitest::Test
  def setup
    team_file_path = './data/teams.csv'
    @team_collection = TeamCollection.new(team_file_path)

    game_team_file_path = './test/fixtures/truncated_game_teams.csv'
    @game_team_collection = GameTeamCollection.new(game_team_file_path)

    game_file_path = './test/fixtures/truncated_games.csv'
    @game_collection = GameCollection.new(game_file_path)

    @season = Season.new(@game_collection, @team_collection, @game_team_collection, "20122013")
  end

  def test_it_exists
    assert_instance_of Season, @season
  end

  def test_it_can_get_season_games
    assert_instance_of Array, @season.get_season_games("20122013")
    assert_equal 257, @season.get_season_games("20122013").length
    assert_equal "20122013", @season.get_season_games("20122013").first.season
  end

  def test_it_has_attributes
    assert_instance_of Array, @season.all_games
    assert_equal 257, @season.all_games.length
    assert_instance_of Game, @season.all_games.first
  end

  def test_it_can_count_season_games
    assert_equal 257, @season.count_of_season_games("20122013")
  end

  def test_it_can_get_season_games_by_type
    assert_instance_of Array, @season.games_by_type('Regular Season')
    assert_equal 'Regular Season', @season.games_by_type('Regular Season').first.type
    assert_instance_of Array, @season.games_by_type('Postseason')
    assert_equal 'Postseason', @season.games_by_type('Postseason').first.type
    assert_equal [], @season.games_by_type('Overtime')
  end

  def test_it_get_team_info_by_team
    assert_instance_of Hash, @season.get_team_info
    assert_equal 32, @season.get_team_info.length
    assert_equal 1, @season.get_team_info.keys.first
    assert_equal 'Atlanta United', @season.get_team_info[1][:team_name]
  end

  def test_it_can_get_total_team_games_by_game_type
    assert_equal 19, @season.total_team_games_by_game_type(29, 'Regular Season')
    assert_equal 15, @season.total_team_games_by_game_type(17, 'Regular Season')
    assert_equal 14, @season.total_team_games_by_game_type(17, 'Postseason')
  end

  def test_it_can_get_total_team_wins_by_game_type
    assert_equal 4, @season.total_team_wins_by_game_type(29, 'Regular Season')
    assert_equal 7, @season.total_team_wins_by_game_type(1, 'Regular Season')
    assert_equal 0, @season.total_team_wins_by_game_type(1, 'Postseason')
    assert_equal 9, @season.total_team_wins_by_game_type(17, 'Regular Season')
    assert_equal 7, @season.total_team_wins_by_game_type(17, 'Postseason')
  end

  def test_it_can_calculate_team_win_percentage
    assert_equal 21.05, @season.team_win_percentage(29, 'Regular Season')
    assert_equal 50.00, @season.team_win_percentage(17, 'Postseason')
    assert_equal 60.00, @season.team_win_percentage(17, 'Regular Season')
  end

  def test_it_can_calculate_biggest_bust
    skip
    @season.get_team_info
    @season.get_regular_percents('Regular Season')
  end
end
