require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/game_teams'
require './lib/game'
require './lib/team_collection'
require './lib/team'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
        games: './fixture_files/games_fixture.csv',
        # games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './fixture_files/game_teams_fixture.csv'
        # game_teams: './data/game_teams.csv'
      }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_load_collections_of_various_data
    assert_instance_of GameTeamsCollection, @stat_tracker.gtc
    assert_equal GameTeams, @stat_tracker.gtc.game_teams.first.class
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_equal Game, @stat_tracker.game_collection.games.first.class
    assert_instance_of TeamCollection, @stat_tracker.team_collection
    assert_equal Team, @stat_tracker.team_collection.teams.first.class
  end

  def test_it_can_return_the_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_return_the_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.33, @stat_tracker.percentage_ties
  end

  def test_it_can_show_the_worst_fans
    assert_equal [], @stat_tracker.worst_fans
  end

  def test_it_knows_the_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_knows_the_hightest_scoring_home_team
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_return_the_best_overall_defense
    assert_equal "FC Dallas", @stat_tracker.best_defense
  end

  def test_it_can_return_the_worst_coach_of_the_season
    skip
    assert_equal "John Tortorella", @stat_tracker.worst_coach(20132014)
  end


  ######  Move these tests somewhere else

  def test_it_can_return_total_games_by_season
    expected = {
      20122013=>5,
      20152016=>4
      }
    assert_equal expected, @stat_tracker.total_games_by_season
  end

  def test_it_can_count_total_games_by_team
    expected = {3=>3, 6=>2, 9=>1, 8=>1, 5=>4, 20=>1, 19=>1,
      7=>1, 52=>1, 10=>1, 26=>1, 22=>1}

    assert_equal expected, @stat_tracker.total_games_by_team
  end

  def test_it_can_count_all_goals_scored_by_team
    expected = {3=>6, 6=>6, 9=>2, 8=>2, 5=>7, 20=>1, 19=>2,
    7=>1, 52=>2, 10=>1, 26=>2, 22=>2}
    assert_equal expected, @stat_tracker.all_goals_scored_by_team
  end

  def test_it_can_count_goals_allowed_by_team
    expected = {3=>8, 6=>2, 9=>2, 8=>2, 5=>9, 20=>2, 19=>1, 7=>2,
      52=>1, 10=>2, 26=>1, 22=>2}

    assert_equal expected, @stat_tracker.all_goals_allowed_by_team
  end

  def test_it_can_return_team_names_by_id_number
    assert_equal "Atlanta United", @stat_tracker.team_name_by_id(1)
    assert_equal "LA Galaxy", @stat_tracker.team_name_by_id(17)
  end

  def test_it_can_show_total_wins
    expected = {3=>0, 6=>2, 5=>1, 20=>0, 19=>1, 7=>0, 52=>1, 10=>0, 26=>1}
    assert_equal expected, @stat_tracker.total_wins_by_team
  end

  def test_it_can_show_total_loss
    expected = {3=>2, 6=>0, 5=>0, 20=>1, 19=>0, 7=>1, 52=>0, 10=>1, 26=>0}
    assert_equal expected, @stat_tracker.total_loss_by_team
  end

  def test_it_can_show_total_ties
    expected = {3=>1, 6=>0, 9=>1, 8=>1, 5=>2, 20=>0, 19=>0,
      7=>0, 52=>0, 10=>0, 26=>0, 22=>1}
    assert_equal expected, @stat_tracker.total_tie_by_team
  end

  def test_it_can_display_home_or_away_games_by_team
    expected_home = {6=>1, 8=>1, 5=>4, 19=>1, 52=>1, 26=>1}

    assert_equal expected_home, @stat_tracker.hoa_games_by_team("home")

    expected_away = {3=>3, 9=>1, 6=>1, 20=>1, 7=>1, 10=>1, 22=>1}
    assert_equal expected_away, @stat_tracker.hoa_games_by_team("away")
  end

  def test_it_can_display_all_goals_scored_hoa_by_team
    expected_home = {3=>0, 6=>3, 9=>0, 8=>2, 5=>7, 20=>0, 19=>2,
      7=>0, 52=>2, 10=>0, 26=>2, 22=>0}
    assert_equal expected_home, @stat_tracker.hoa_goals_by_team("home")

    expected_away = {3=>6, 6=>3, 9=>2, 8=>0, 5=>0, 20=>1,
      19=>0, 7=>1, 52=>0, 10=>1, 26=>0, 22=>2}

    assert_equal expected_away, @stat_tracker.hoa_goals_by_team("away")
  end

  def test_it_can_display_home_or_away_wins_by_team
    expected_home = {3=>0, 6=>1, 9=>0, 8=>0, 5=>1, 20=>0, 19=>1,
      7=>0, 52=>1, 10=>0, 26=>1, 22=>0}
    assert_equal expected_home, @stat_tracker.hoa_wins_by_team("home")

    expected_away = {3=>0, 6=>1, 9=>0, 8=>0, 5=>0, 20=>0, 19=>0,
      7=>0, 52=>0, 10=>0, 26=>0, 22=>0}

    assert_equal expected_away, @stat_tracker.hoa_wins_by_team("away")
  end

  def test_it_can_display_home_or_away_losses_by_team
    expected_home = {3=>0, 6=>0, 9=>0, 8=>0, 5=>1, 20=>0,
      19=>0, 7=>0, 52=>0, 10=>0, 26=>0, 22=>0}
    assert_equal expected_home, @stat_tracker.hoa_loss_by_team("home")

    expected_away = {3=>2, 6=>0, 9=>0, 8=>0, 5=>0, 20=>1, 19=>0, 7=>1,
      52=>0, 10=>1, 26=>0, 22=>0}
    assert_equal expected_away, @stat_tracker.hoa_loss_by_team("away")
  end

  def test_it_can_display_home_or_away_ties_by_team
    expected_home = {3=>0, 6=>0, 9=>0, 8=>1, 5=>2, 20=>0, 19=>0,
      7=>0, 52=>0, 10=>0, 26=>0, 22=>0}
    assert_equal expected_home, @stat_tracker.hoa_tie_by_team("home")

    expected_away = {3=>1, 6=>0, 9=>1, 8=>0, 5=>0, 20=>0, 19=>0,
      7=>0, 52=>0, 10=>0, 26=>0, 22=>1}
    assert_equal expected_away, @stat_tracker.hoa_tie_by_team("away")
  end

  ### Seasonal Stats Below
  def test_it_knows_all_the_game_ids_in_a_given_season
    assert_equal [2012030221, 2012030121, 2012030311, 2012020701, 2012020587], @stat_tracker.game_ids_in_season(20122013)
  end

  def test_it_knows_the_number_of_games_played_by_teams_in_a_season
    expected = {3 => 2, 5 => 3, 10 => 1, 26 => 1, 22 => 1}
    assert_equal expected, @stat_tracker.games_by_team_by_season(20152016)
  end

  def test_it_knows_coachs_by_season
    expected_1213 = {
      3 => "John Tortorella",
      6 => "Claude Julien",
      9 => "Paul MacLean",
      8 => "Michel Therrien",
      5 => "Dan Bylsma",
      20 => "Bob Hartley",
      19 => "Ken Hitchcock",
      7 => "Ron Rolston",
      52 => "Claude Noel"

    }
    assert_equal expected_1213, @stat_tracker.head_coaches(20122013)

  end

  def test_it_knows_wins_by_season
    skip
    expected = {5 => 1, 26 => 1}
    assert_equal expected, @stat_tracker.wins_in_season(20152016)

  end

end
