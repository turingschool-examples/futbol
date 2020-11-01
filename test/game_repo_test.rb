require './test/test_helper'

class GameRepoTest < Minitest::Test
  def setup
    @games_path = './dummy_data/games_dummy.csv'
    @games_repo_test = GameRepo.new(@games_path)
  end

  def test_make_games
    assert_instance_of Game, @games_repo_test.make_games(@games_path)[0]
    assert_instance_of Game, @games_repo_test.make_games(@games_path)[-1]
  end

  def test_it_can_return_total_away_games
    assert_instance_of Game, @games_repo_test.total_games_per_team_away("3")[0]
    assert_instance_of Game, @games_repo_test.total_games_per_team_away("3")[-1]
  end

  def test_it_can_return_total_home_games
    assert_instance_of Game, @games_repo_test.total_games_per_team_home("6")[0]
    assert_instance_of Game, @games_repo_test.total_games_per_team_home("6")[-1]
  end

  def test_it_can_return_season_by_game_id
    expected = {
      "20122013" => %w[2012030221 2012030222 2012030223 2012030224]
    }
    assert_equal expected, @games_repo_test.season_game_ids
  end

  def test_it_can_count_teams
    assert_equal 2, @games_repo_test.count_of_teams
  end

  def test_it_can_return_games_by_season_id
    assert_equal %w[2012030221 2012030222 2012030223 2012030224], @games_repo_test.game_ids_by_season("20122013")
  end

  def test_it_can_return_highest_net_score
    assert_equal 5, @games_repo_test.highest_total_score
  end

  def test_it_can_return_lowest_net_score
    assert_equal 3, @games_repo_test.lowest_total_score
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 0.5,  @games_repo_test.percentage_home_wins
  end
  
  def test_it_can_return_percentage_visitor_wins
    assert_equal 0.5, @games_repo_test.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.0, @games_repo_test.percentage_ties
  end

  def test_it_can_return_count_of_games_by_season
    expected = {"20122013"=>4}
    assert_equal expected,  @games_repo_test.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game
    assert_equal 4.5 , @games_repo_test.average_goals_per_game
  end

  def test_it_can_average_goals_by_season
    expected =  {"20122013"=>4.5}
    assert_equal expected , @games_repo_test.average_goals_by_season
  end
end