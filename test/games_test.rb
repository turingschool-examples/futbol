require './test/test_helper'
require './lib/games'
require './lib/team'

class GamesTest < Minitest::Test

  def setup
    Games.from_csv('./data/games_dummy.csv')
    @game = Games.all[0]

    Team.from_csv('./data/teams.csv')
    @team = Team.all[0]
  end

  def test_it_exists
    assert_instance_of Games, @game
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
  end

  def test_it_can_calculate_highest_total_score

    assert_equal 6, Games.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, Games.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 5, Games.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.53, Games.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.41, Games.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.06, Games.percentage_ties
  end

  def test_it_can_count_games_by_season
    assert_equal ({20122013 => 5, 20142015 => 12, 20152016 => 1, 20172018 => 9, 20132014=>4, 20162017=>1}), Games.count_of_games_by_season
  end

  def test_it_calculate_average_goals_per_game
    assert_equal 4.13, Games.average_goals_per_game
  end

  def test_it_calculate_average_goals_per_season
    assert_equal ({20122013 => 4.6, 20142015 => 3.84, 20152016 => 3.0, 20172018 => 4.33, 20132014=>4.0, 20162017=>5.0}), Games.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 32, Games.count_of_teams
  end

  def test_finds_team_with_best_offense
    assert_equal "Reign FC", Games.best_offense
  end
end
