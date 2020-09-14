require './test/test_helper'
require './lib/game_manager'
require './lib/stat_tracker'

class GameManagerTest < Minitest::Test
  def setup
    @game_path = './fixtures/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixtures/fixture_game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_with_best_offense
    assert_equal "Minnesota United FC", @stat_tracker.best_offense
  end

  def test_with_worst_offense
    assert_equal "Columbus Crew SC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Minnesota United FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Columbus Crew SC", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Philadelphia Union", @stat_tracker.lowest_scoring_home_team
  end

  def test_home_team_data_collection
    stat_tracker = mock('stat tracker object')
    game_manager = GameManager.new(@locations, stat_tracker)
    assert_equal 496, game_manager.data_home.count
  end

  def test_away_team_data_collection
    stat_tracker = mock('stat tracker object')
    game_manager = GameManager.new(@locations, stat_tracker)
    assert_equal 496, game_manager.data_away.count
  end

  def test_average_goals_per_game
    stat_tracker = mock('stat tracker object')
    game_manager = GameManager.new(@locations, stat_tracker)
    team_data_hash = {"1" => "I made a big mistake", "2" => "This is not a real team name", "3" => "For testing purposes only"}
    scoredata = [["1", 1], ["1",0], ["1",1], ["2",2], ["2",4],["2",2] ,["3",3], ["3",3], ["3",3]]
    expected = {"1" => 0.6667,"2" => 2.6667,"3" => 3}
    game_manager.stubs(:team_data).returns(team_data_hash)
    assert_equal expected, game_manager.return_average_goals_per_game(scoredata)
    @stat_tracker = mock('stat tracker object')
    @game_manager = GameManager.new(@locations, @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_it_has_readable_attributes
    game_manager = mock('game manager object')
    game_1 = mock('game object 1')
    game_2 = mock('game object 2')
    game_3 = mock('game object 2')
    game_4 = mock('game object 2')
    game_5 = mock('game object 2')
    game_manager.stubs(:games).returns([game_1, game_2, game_3, game_4, game_5])
    assert_equal [game_1, game_2, game_3, game_4, game_5], game_manager.games
  end

  def test_it_can_find_highest_total_score
    assert_equal 9, @game_manager.highest_total_score
  end

  def test_it_can_find_lowest_score
    assert_equal 0, @game_manager.lowest_total_score
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.36, @game_manager.percentage_visitor_wins
    assert_equal 178, @game_manager.percentage_visitor_win_helper
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.21, @game_manager.percentage_ties
    assert_equal 105, @game_manager.percentage_ties_helper
    assert_equal 0.43, @game_manager.percentage_home_wins
    assert_equal 213, @game_manager.percentage_home_win_helper
  end

  def test_it_can_count_games_by_season
    expected = { '20122013' => 92,
                 '20142015' => 109,
                 '20152016' => 118,
                 '20132014' => 75,
                 '20162017' => 74,
                 '20172018' => 28 }
    assert_equal expected, @game_manager.count_of_games_by_season
    assert_equal 496, @game_manager.count_of_games_by_season.values.sum
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 4.21, @game_manager.average_goals_per_game
  end

  def test_it_can_find_average_goals_per_season
    expected = { '20122013' => 4.17,
                 '20142015' => 4.06,
                 '20152016' => 4.22,
                 '20132014' => 4.37,
                 '20162017' => 4.19,
                 '20172018' => 4.46 }
    assert_equal expected, @game_manager.average_goals_by_season
  end
end
