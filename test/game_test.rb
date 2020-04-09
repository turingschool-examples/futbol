require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "pry"
require "mocha/minitest"

class GameTest < Minitest::Test

  def setup
    @base_game = Game.new({:game_id => 123,
                :season => 456,
                :type => "good",
                :date_time => "12/20/20",
                :away_team_id => 45,
                :home_team_id => 36,
                :away_goals => 3,
                :home_goals => 3,
                :venue => "Heaven",
                :venue_link => "venue/link"})

    Game.from_csv('./test/fixtures/games_20.csv')
    @game = Game.all[0]
  end

  def test_it_exists
    assert_instance_of Game, @base_game
  end

  def test_it_has_attributes
    assert_equal 123, @base_game.game_id
    assert_equal 456, @base_game.season
    assert_equal "good", @base_game.type
    assert_equal "12/20/20", @base_game.date_time
    assert_equal 45, @base_game.away_team_id
    assert_equal 36, @base_game.home_team_id
    assert_equal 3, @base_game.away_goals
    assert_equal 3, @base_game.home_goals
    assert_equal "Heaven", @base_game.venue
    assert_equal "venue/link", @base_game.venue_link
  end

  def test_it_can_create_game_from_csv
    assert_equal 2012030221, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_it_has_all
    assert_instance_of Array, Game.all
    assert_equal 20, Game.all.length
    assert_instance_of Game, Game.all.first
  end
#deliverable
  def test_it_returns_average_goals_per_game
    assert_equal 4.4, Game.average_goals_per_game
  end

  def test_games_per_season
    assert_equal [2, 5, 6, 4, 2, 1], Game.games_per(:season)
  end

  def test_home_and_away_goals_per_season
    assert_equal [4, 10, 13, 10, 4, 3], Game.goals_per(:season, :away_goals)
    assert_equal [6, 12, 11, 8, 5, 2], Game.goals_per(:season, :home_goals)
  end

  def test_average_home_and_away_goals_per_season
    away_goals = Game.goals_per(:season, :away_goals)
    home_goals = Game.goals_per(:season, :home_goals)
    games = Game.games_per(:season)
    assert_equal [2.0, 2.0, 2.17, 2.5, 2.0, 3.0], Game.average_goals(away_goals, games)
    assert_equal [3.0, 2.4, 1.83, 2.0, 2.5,2.0], Game.average_goals(home_goals, games)
  end

  def test_average_goals_per_csv_header
    goals = [10, 20]
    season_lengths = [3, 8]
    assert_equal [3.33, 2.5], Game.average_goals(goals, season_lengths)
  end
#deliverable
  def test_average_goals_by_season
    Game.all.stubs(:map).returns([20122013, 20162017])
    Game.stubs(:average_goals).returns([3.33, 2.5])
    expected = {20122013 => 3.33, 20162017 => 2.5}
    assert_equal expected, Game.average_goals_by_season
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 5, @game.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 3, @game.lowest_total_score
  end
#deliverable
  def test_it_can_count_games_by_season
    assert_equal ({20122013=>2, 20162017=>5, 20142015=>6, 20132014=>4, 20152016=>2, 20172018=>1}), Game.count_of_games_by_season
  end
#deliverable
  def test_highest_scoring_visitor_team_id
    Game.all.stubs(:map).returns([1, 2, 3, 4])#team_ids
    Game.stubs(:goals_per).returns([80, 60, 40, 20])#away_goals
    Game.stubs(:games_per).returns([10, 10, 10, 10])#games
    assert_equal 1, Game.highest_scoring_visitor_team_id
    #lowe
  end
#deliverable
  def test_highest_scoring_home_team_id
    Game.all.stubs(:map).returns([1, 2, 3, 4]) #team ids
    Game.stubs(:goals_per).returns([60, 80, 20, 40]) #home_goals
    Game.stubs(:games_per).returns([10, 10, 10, 10]) #games
    assert_equal 2, Game.highest_scoring_home_team_id
  end
#deliverable
  def test_lowest_scoring_away_team_id
    Game.all.stubs(:map).returns([1, 2, 3, 4])#team_ids
    Game.stubs(:goals_per).returns([80, 60, 40, 20])#away_goals
    Game.stubs(:games_per).returns([10, 10, 10, 10])#games
    assert_equal 4, Game.lowest_scoring_visitor_team_id
  end
#deliverable
  def test_lowest_scoring_home_team_id
    Game.all.stubs(:map).returns([1, 2, 3, 4]) #team ids
    Game.stubs(:goals_per).returns([60, 80, 20, 40]) #home_goals
    Game.stubs(:games_per).returns([10, 10, 10, 10]) #games
    assert_equal 3, Game.lowest_scoring_visitor_team_id
  end

  def test_it_identifies_wins_given_team_id_game_id
    assert_equal true, Game.win?(16, 2014030412)
    assert_equal true, Game.win?(26, 2017020625)
    assert_equal false, Game.win?(30, 2015020906)
    assert_equal false, Game.win?(19, 2013020918) #tie
  end

  def test_it_returns_all_games_by_seasons_given_team_id
    assert_equal ({20122013 => 2, 20142015 => 4}), Game.games_by_season(3)
    assert_equal ({20122013 => 2}), Game.games_by_season(6)
  end

  def test_it_returns_wins_by_seasons_given_team_id
    assert_equal ({20122013 => 0, 20142015 => 4}), Game.wins_by_season(3)
    assert_equal ({20122013 => 2}), Game.wins_by_season(6)
  end
#deliverable
  def test_it_returns_best_season_given_team_id
    assert_equal "In the 20142015 season Team 3 won 100% of games", Game.best_season(3)
    assert_equal "In the 20122013 season Team 6 won 100% of games", Game.best_season(6)
    assert_equal "In the 20162017 season Team 20 won 0% of games", Game.best_season(20)
    stub_val = {
                20122013 => 25,
                20132014 => 66,
                20142015 => 44,
                20152016 => 35,
                }
    Game.stubs(:percent_by_season).returns(stub_val)
    assert_equal "In the 20132014 season Team 3 won 66% of games", Game.best_season(3)
  end
#deliverable
  def test_it_returns_worst_season_given_team_id
    Game.best_season(3)
    assert_equal "In the 20122013 season Team 3 won 0% of games", Game.worst_season(3)
    assert_equal "In the 20122013 season Team 6 won 100% of games", Game.worst_season(6)
    assert_equal "In the 20162017 season Team 20 won 0% of games", Game.worst_season(20)
    stub_val = {
                20122013 => 25,
                20132014 => 66,
                20142015 => 44,
                20152016 => 35,
                }
    Game.stubs(:percent_by_season).returns(stub_val)
    assert_equal "In the 20122013 season Team 3 won 25% of games", Game.worst_season(3)
  end
end
