require_relative 'test_helper'
require_relative '../lib/stat_tracker'


class StatTrackerTest < Minitest::Test
  def setup
    file_paths = {
                  games: './data/dummy_games.csv',
                  teams: './data/dummy_teams.csv',
                  game_teams: './data/dummy_games_teams.csv'
                }
    @stat_tracker = StatTracker.from_csv(file_paths)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes_with_attributes
    assert_instance_of GamesCollection, @stat_tracker.games
    assert_instance_of TeamsCollection, @stat_tracker.teams
    assert_instance_of GamesTeamsCollection, @stat_tracker.games_teams
  end

  # Begin tests for iteration-required methods

  def test_it_grabs_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_it_grabs_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_has_a_big_blow_out
    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_it_calculates_home_win_percentage_to_the_hundredths
    assert_equal 0.65, @stat_tracker.percentage_home_wins
  end

  def test_it_calculates_away_win_percentage_to_the_hundredths
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_it_calculates_percentage_ties
    assert_equal 0.02, @stat_tracker.percentage_ties
  end

  def test_it_can_count_game_by_season

    expected = {
      "20122013" => 63,
      "20162017" => 4,
      "20142015" => 16,
      "20152016" => 16,
      "20132014" => 12
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 3.99, @stat_tracker.average_goals_per_game
  end

  def test_it_can_return_hash_of_average_goals_by_season
    expected_hash = {
                      "20122013"=>3.9,
                      "20162017"=>4.75,
                      "20142015"=>3.75,
                      "20152016"=>3.88,
                      "20132014"=>4.67
                    }
    assert_equal expected_hash, @stat_tracker.average_goals_by_season
  end

  def test_it_knows_how_many_teams_there_are
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_get_name_of_team_by_id
    assert_equal "FC Dallas", @stat_tracker.name_of_team("6")
    assert_equal "Los Angeles FC", @stat_tracker.name_of_team("28")
  end

  def test_it_can_tell_name_of_highest_scoring_home_team
    assert_equal "Chicago Red Stars", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_tell_name_of_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_tell_name_of_lowest_scoring_home_team
    assert_equal "Chicago Fire", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_tell_name_of_lowest_scoring_visitor
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_find_name_of_winningest_team
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_it_can_find_team_with_best_fans
    assert_equal "New England Revolution", @stat_tracker.best_fans
  end

  def test_it_can_find_names_of_teams_with_worst_fans
    # no such teams exist in fixture data, but 2 exist in real data
    assert_equal [], @stat_tracker.worst_fans
  end

  def test_it_can_find_team_with_best_offense
    assert_equal "New York City FC", @stat_tracker.best_offense
  end

  def test_it_can_find_team_with_worst_offense
    assert_equal "Orlando City SC", @stat_tracker.worst_offense
  end

  def test_it_can_find_team_with_best_defense
    assert_equal "FC Dallas", @stat_tracker.best_defense
  end

  def test_it_can_find_team_with_worst_defense
    assert_equal "New York Red Bulls", @stat_tracker.worst_defense
  end

  def test_it_has_a_biggest_team_blowout
    assert_equal 3, @stat_tracker.biggest_team_blowout("2")
  end

  def test_it_can_find_the_most_goals_scored
    assert_equal 4, @stat_tracker.most_goals_scored("2")
  end

  def test_it_can_find_the_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("2")
  end

  def test_it_can_tell_us_best_season_for_given_team
    assert_equal "20122013", @stat_tracker.best_season("2")
  end

  def test_it_can_tell_us_worst_season_for_given_team
    assert_equal "20122013", @stat_tracker.worst_season("2")
  end

  def test_it_calculates_win_percentage_for_given_team_id
    assert_equal 1.00, @stat_tracker.average_win_percentage("6")
    assert_equal 0.33, @stat_tracker.average_win_percentage("2")
    assert_equal 0.40, @stat_tracker.average_win_percentage("5")
  end

  def test_it_has_a_worst_loss
    assert_equal 3, @stat_tracker.worst_loss("2")
  end

<<<<<<< HEAD
  def test_it_has_a_seasonal_summary
  expected = {"20162017"=>
          {:postseason=>
            {:win_percentage=>0.59,
             :total_goals_scored=>48,
             :total_goals_against=>40,
             :average_goals_scored=>2.18,
             :average_goals_against=>1.82},
           :regular_season=>
            {:win_percentage=>0.38,
             :total_goals_scored=>180,
             :total_goals_against=>170,
             :average_goals_scored=>2.2,
             :average_goals_against=>2.07}},
         "20172018"=>
          {:postseason=>
            {:win_percentage=>0.54,
             :total_goals_scored=>29,
             :total_goals_against=>28,
             :average_goals_scored=>2.23,
             :average_goals_against=>2.15},
           :regular_season=>
            {:win_percentage=>0.44,
             :total_goals_scored=>187,
             :total_goals_against=>162,
             :average_goals_scored=>2.28,
             :average_goals_against=>1.98}},
         "20132014"=>
          {:postseason=>
            {:win_percentage=>0.0,
             :total_goals_scored=>0,
             :total_goals_against=>0,
             :average_goals_scored=>0.0,
             :average_goals_against=>0.0},
           :regular_season=>
            {:win_percentage=>0.38,
             :total_goals_scored=>166,
             :total_goals_against=>177,
             :average_goals_scored=>2.02,
             :average_goals_against=>2.16}},
         "20122013"=>
          {:postseason=>
            {:win_percentage=>0.0,
             :total_goals_scored=>0,
             :total_goals_against=>0,
             :average_goals_scored=>0.0,
             :average_goals_against=>0.0},
           :regular_season=>
            {:win_percentage=>0.25,
             :total_goals_scored=>85,
             :total_goals_against=>103,
             :average_goals_scored=>1.77,
             :average_goals_against=>2.15}},
         "20142015"=>
          {:postseason=>
            {:win_percentage=>0.67,
             :total_goals_scored=>17,
             :total_goals_against=>13,
             :average_goals_scored=>2.83,
             :average_goals_against=>2.17},
           :regular_season=>
            {:win_percentage=>0.5,
             :total_goals_scored=>186,
             :total_goals_against=>162,
             :average_goals_scored=>2.27,
             :average_goals_against=>1.98}},
         "20152016"=>
          {:postseason=>
            {:win_percentage=>0.36,
             :total_goals_scored=>25,
             :total_goals_against=>33,
             :average_goals_scored=>1.79,
             :average_goals_against=>2.36},
           :regular_season=>
            {:win_percentage=>0.45,
             :total_goals_scored=>178,
             :total_goals_against=>159,
             :average_goals_scored=>2.17,
             :average_goals_against=>1.94}}}

    expect(@stat_tracker.seasonal_summary("18")).to eq expected
  end
=======
  # def test_it_has_a_seasonal_summary
  #   # expected = {
  #   #   "stuff" => "things"
  #   #   "other stuff" => "more things"
  #   # }
  #
  #   assert_equal expected, @stat_tracker.seasonal_summary("2")
  # end

>>>>>>> 256e0aed8c6bc8381ab9e878620dee7e50433ebe
end
