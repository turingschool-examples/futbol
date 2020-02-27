require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require './lib/game_teams_collection'

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @game_team_data = CSV.read('./fixture_files/game_teams_fixture.csv',
                              headers: true,
                              header_converters: :symbol)
    @gtc = GameTeamsCollection.new(@game_team_data)
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @gtc
  end

  def test_it_can_create_an_array_of_game_team_objects
    assert_instance_of Array, @gtc.game_teams
    assert_instance_of GameTeams, @gtc.game_teams.first
  end

  def test_it_has_as_many_teams_as_data_lines
    assert_equal @gtc.game_teams.size, @game_team_data.size
  end

  def test_it_has_real_data
    assert_equal 44.8, @gtc.game_teams.first.face_off_win_percentage
    assert_equal 2012030221, @gtc.game_teams.first.game_id
    assert_equal 17, @gtc.game_teams.first.giveaways
    assert_equal 2, @gtc.game_teams.first.goals
    assert_equal "John Tortorella", @gtc.game_teams.first.head_coach
    assert_equal "away", @gtc.game_teams.first.hoa
    assert_equal 8, @gtc.game_teams.first.pim
    assert_equal 0, @gtc.game_teams.first.power_play_goals
    assert_equal 3, @gtc.game_teams.first.power_play_opportunities
    assert_equal "LOSS", @gtc.game_teams.first.result
    assert_equal "OT", @gtc.game_teams.first.settled_in
    assert_equal 8, @gtc.game_teams.first.shots
    assert_equal 44, @gtc.game_teams.first.tackles
    assert_equal 7, @gtc.game_teams.first.takeaways
    assert_equal 3, @gtc.game_teams.first.team_id
  end

  def test_it_can_display_home_or_away_games_by_team
    expected_home = {6=>1, 8=>1, 5=>4, 19=>1, 52=>1, 26=>1}

    assert_equal expected_home, @gtc.hoa_games_by_team("home")

    expected_away = {3=>3, 9=>1, 6=>1, 20=>1, 7=>1, 10=>1, 22=>1}
    assert_equal expected_away, @gtc.hoa_games_by_team("away")
  end

  def test_it_can_display_all_goals_scored_hoa_by_team
    expected_home = {3=>0, 6=>3, 9=>0, 8=>2, 5=>7, 20=>0, 19=>2,
      7=>0, 52=>2, 10=>0, 26=>2, 22=>0}
    assert_equal expected_home, @gtc.hoa_goals_by_team("home")

    expected_away = {3=>6, 6=>3, 9=>2, 8=>0, 5=>0, 20=>1,
      19=>0, 7=>1, 52=>0, 10=>1, 26=>0, 22=>2}

    assert_equal expected_away, @gtc.hoa_goals_by_team("away")
  end

  def test_it_can_display_home_or_away_wins_by_team
    expected_home = {3=>0, 6=>1, 9=>0, 8=>0, 5=>1, 20=>0, 19=>1,
      7=>0, 52=>1, 10=>0, 26=>1, 22=>0}
    assert_equal expected_home, @gtc.hoa_wins_by_team("home")

    expected_away = {3=>0, 6=>1, 9=>0, 8=>0, 5=>0, 20=>0, 19=>0,
      7=>0, 52=>0, 10=>0, 26=>0, 22=>0}

    assert_equal expected_away, @gtc.hoa_wins_by_team("away")
  end

  def test_it_can_show_total_wins
    expected = {3=>0, 6=>2, 5=>1, 20=>0, 19=>1, 7=>0, 52=>1, 10=>0, 26=>1}
    assert_equal expected, @gtc.total_wins_by_team
  end

  def test_average_scores_at_home
    expected = {6=>3.0, 8=>2.0, 5=>1.75, 19=>2.0, 52=>2.0, 26=>2.0}
    assert_equal expected, @gtc.scores_as_home_team
  end
end
