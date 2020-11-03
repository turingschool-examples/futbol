require './test/test_helper'

class GameCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    @stat_tracker    = StatTracker.from_csv(locations)
    @game_collection = GameCollection.new(game_path, @stat_tracker)
    @team_id = '3'
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameCollection, @game_collection
  end

  def test_scores_by_game
    assert_equal 57, @game_collection.scores_by_game.count
  end

  def test_it_calls_highest_total_score
    assert_equal 6, @game_collection.highest_total_score
  end

  def test_it_calls_lowest_total_score
    assert_equal 1, @game_collection.lowest_total_score
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>57}
    assert_equal expected, @game_collection.count_of_games_by_season
  end

  def test_total_games
    assert_equal 57, @game_collection.total_amount_games
  end

  def test_average_goals_per_game
    assert_equal 3.86, @game_collection.average_goals_per_game
  end

  def test_sum_of_scores_by_season
    expected = {"20122013"=>220}
    assert_equal expected, @game_collection.sum_of_scores_by_season
  end

  def test_season_id
    assert_equal ["20122013"], @game_collection.season_id
  end

  def test_average_goals_by_season
    expected = {"20122013"=>3.86}
    assert_equal expected, @game_collection.average_goals_by_season
  end

   def test_game_ids_per_season
      expected = {"20122013"=>3.86}
      assert_equal 1, @game_collection.game_ids_per_season.count
  end
  # LeagueStatistics
  def test_it_knows_total_games_per_team_id_away
    expected = {"3"=>7, "6"=>4, "5"=>5, "17"=>8, "16"=>7, "9"=>3, "8"=>2, "30"=>3, "26"=>6, "19"=>3, "24"=>3, "2"=>3, "15"=>3}
    assert_equal expected, @game_collection.total_games_per_team_id_away
  end

  def test_it_knows_total_games_per_team_id_home
    expected = {"6"=>5, "3"=>5, "5"=>5, "16"=>10, "17"=>6, "8"=>3, "9"=>2, "30"=>2, "19"=>3, "26"=>5, "24"=>4, "2"=>3, "15"=>4}
    assert_equal expected, @game_collection.total_games_per_team_id_home
  end

  def test_it_knows_total_goals_per_team_id_away
    expected = {
                "3"=>10.0, "6"=>12.0, "5"=>8.0, "17"=>14.0, "16"=>12.0, "9"=>7.0,
                "8"=>3.0, "30"=>4.0, "26"=>11.0, "19"=>4.0, "24"=>7.0, "2"=>2.0, "15"=>6.0
              }
    assert_equal expected, @game_collection.total_goals_per_team_id_away
  end

  def test_it_knows_total_goals_per_team_id_home
    expected = {"6"=>12.0, "3"=>8.0, "5"=>9.0, "16"=>21.0, "17"=>13.0, "8"=>6.0, "9"=>7.0, "30"=>3.0, "19"=>6.0, "26"=>10.0, "24"=>10.0, "2"=>9.0, "15"=>6.0}
    assert_equal expected, @game_collection.total_goals_per_team_id_home
  end
  # TEAM STATS
  def test_it_can_find_wins_by_season_per_team_id
    assert_equal 1, @game_collection.wins_by_season_per_team_id(@team_id).count
  end

  def test_it_can_find_winning_games_by_team_id
    assert_equal 2, @game_collection.winning_games(@team_id).count
  end

  def test_it_can_find_best_season
    assert_equal '20122013', @game_collection.best_season(@team_id)
  end

  def test_it_can_find_worst_season
    assert_equal "20122013", @game_collection.worst_season(@team_id)
  end
end
