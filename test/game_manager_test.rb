require './test/test_helper'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < Minitest::Test
  def setup
    @game_manager = GameManager.new('./data/games.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameManager, @game_manager
    assert_equal Array, @game_manager.games.class
  end

  def test_it_can_add_array_of_all_game_objects
    assert_instance_of Game, @game_manager.games.first
  end

  def test_it_calculates_highest_total_score
    assert_equal 11, @game_manager.highest_total_score
  end

  def test_it_calculates_lowest_total_score
    assert_equal 0, @game_manager.lowest_total_score
  end

  def test_it_gives_percentage_of_home_wins
    assert_equal 0.44, @game_manager.percentage_home_wins
  end

  def test_it_gives_percentage_of_visitor_wins
    assert_equal 0.36, @game_manager.percentage_visitor_wins
  end

  def test_it_gives_percentage_of_ties
    assert_equal 0.20, @game_manager.percentage_ties
  end

  def test_it_gives_games_by_season_count
    expected = {
                "20122013"=>806,
                "20162017"=>1317,
                "20142015"=>1319,
                "20152016"=>1321,
                "20132014"=>1323,
                "20172018"=>1355
               }
    assert_equal expected, @game_manager.count_of_games_by_season
  end

  def test_it_gives_average_goals_per_game
    assert_equal 4.22, @game_manager.average_goals_per_game
  end

  def test_it_gives_games_by_season
    assert_equal 806, @game_manager.games_by_season('20122013').size
  end

  def test_it_gives_season_game_stats
    assert_equal 806, @game_manager.games_by_season('20122013').size
  end

  def test_it_gives_game_ids_by_season
    assert_equal 806, @game_manager.game_ids_by_season('20122013').size
  end

  def test_it_gives_goal_count_by_season
    assert_equal 3322, @game_manager.goal_count('20122013')
  end

  def test_it_gives_average_goals_by_season
    expected =  {
                  "20122013"=>4.12,
                  "20162017"=>4.23,
                  "20142015"=>4.14,
                  "20152016"=>4.16,
                  "20132014"=>4.19,
                  "20172018"=>4.44
                }
    assert_equal expected, @game_manager.average_goals_by_season
  end

  def test_games_by_team
    assert_equal 463, @game_manager.games_by_team("1").size
  end

  def test_team_games_by_season
    assert_equal 6, @game_manager.team_games_by_season("1").size
  end

  def test_team_season_stats
    expected = {
                 "20172018"=>{:game_count=>87, :win_count=>33},
                 "20122013"=>{:game_count=>48, :win_count=>16},
                 "20132014"=>{:game_count=>82, :win_count=>31},
                 "20142015"=>{:game_count=>82, :win_count=>28},
                 "20162017"=>{:game_count=>82, :win_count=>26},
                 "20152016"=>{:game_count=>82, :win_count=>32}
               }
    assert_equal expected, @game_manager.team_season_stats("1")
  end

  def test_percentage_wins_by_season
    assert @game_manager.percentage_wins_by_season("1").keys.all? do |key|
      key.is_a?(Float)
    end
  end

  def test_best_season
    assert_equal "20132014", @game_manager.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @game_manager.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.49, @game_manager.average_win_percentage("6")
  end

  def test_most_goals_scored
    assert_equal 7, @game_manager.most_goals_scored("18")
    assert_equal 7, @game_manager.most_goals_scored("24")
  end

  def test_fewest_goals_scored
    assert_equal 0, @game_manager.fewest_goals_scored("18")
    assert_equal 0, @game_manager.fewest_goals_scored("53")
  end

  def test_team_games_by_opponent
    assert_equal 31, @game_manager.team_games_by_opponent("18").keys.size
  end

  def test_team_opponent_stats
    assert_equal 31, @game_manager.team_opponent_stats("18").keys.size
    expected = {:game_count=>34, :win_count=>15}
    assert_equal expected, @game_manager.team_opponent_stats("18")["19"]
  end

  def test_percentage_wins_by_opponent
    assert @game_manager.percentage_wins_by_opponent("18").keys.all? do |key|
      key.is_a?(Float)
    end
  end

  def test_favorite_opponent
    assert_equal "14", @game_manager.favorite_opponent("18")
  end

  def test_rival
    assert_equal "13", @game_manager.rival("18")
  end
end
