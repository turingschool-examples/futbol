require './test/test_helper'
require './lib/games'
require './lib/team'
require 'mocha/minitest'

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

  # def test_it_can_calculate_highest_total_score
  #
  #   assert_equal 6, Games.highest_total_score
  # end
  #
  # def test_it_can_calculate_lowest_total_score
  #   assert_equal 1, Games.lowest_total_score
  # end
  #
  # def test_it_can_calculate_biggest_blowout
  #   assert_equal 5, Games.biggest_blowout
  # end
  #
  # def test_it_can_calculate_percentage_home_wins
  #   assert_equal 0.58, Games.percentage_home_wins
  # end
  #
  # def test_it_can_calculate_percentage_visitor_wins
  #   assert_equal 0.37, Games.percentage_visitor_wins
  # end
  #
  # def test_it_can_calculate_percentage_ties
  #   assert_equal 0.05, Games.percentage_ties
  # end
  #
  # def test_it_can_count_games_by_season
  #   assert_equal ({20122013 => 5, 20142015 => 19, 20152016 => 2, 20172018 => 10, 20132014=>5, 20162017=>2}), Games.count_of_games_by_season
  # end
  #
  # def test_it_calculate_average_goals_per_game
  #   assert_equal 4.02, Games.average_goals_per_game
  # end
  #
  # def test_it_calculate_average_goals_per_season
  #   assert_equal ({20122013 => 4.6, 20142015 => 3.790000000000001, 20152016 => 3.0, 20172018 => 4.299999999999999, 20132014=>3.8, 20162017=>5.0}), Games.average_goals_by_season
  # end
  #
  def test_count_of_teams
    assert_equal 32, Games.count_of_teams
  end

  def test_finds_team_with_best_offense
    assert_equal "Reign FC", Games.best_offense
  end

  def test_finds_team_with_worst_offense
    assert_equal "North Carolina Courage", Games.worst_offense
  end

  def test_finds_team_with_best_defense
    assert_equal "North Carolina Courage", Games.best_defense
  end

  def test_finds_team_with_worst_defense
    assert_equal "Los Angeles FC", Games.worst_defense
  end

  def test_finds_team_with_highest_scoring_visitor
    assert_equal "North Carolina Courage", Games.highest_scoring_visitor
  end

  def test_finds_team_with_highest_scoring_home_team
    assert_equal "Reign FC", Games.highest_scoring_home_team
  end

  def test_finds_team_with_lowest_scoring_home_team
    assert_equal "North Carolina Courage", Games.lowest_scoring_home_team
  end

  def test_finds_team_with_lowest_scoring_visitor
    assert_equal "Los Angeles FC", Games.lowest_scoring_visitor
  end

  def test_it_can_find_the_max_value_and_the_team_associated_to_it
    @@team_id_scores = mock({4=>[1, 0, 2],
      26=>[3, 3],
      14=>[1, 3]})
    assert_equal "Los Angeles FC", Games.max_value_team
  end


end
