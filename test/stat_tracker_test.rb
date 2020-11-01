require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

  def setup
  game_path       = './data/games.csv'
  team_path       = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_can_access_data
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_game_ids_per_season
     # expected = {"20122013"=> ["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235", "2012030236", "2012030237", "2012030121", "2012030122", "2012030123", "2012030124", "2012030125", "2012030151", "2012030152", "2012030153", "2012030154", "2012030155", "2012030181", "2012030182", "2012030183", "2012030184", "2012030185", "2012030186", "2012030161", "2012030162", "2012030163", "2012030164", "2012030165", "2012030166", "2012030167", "2012030111", "2012030112", "2012030113", "2012030114", "2012030115", "2012030116", "2012030131", "2012030132", "2012030133", "2012030134", "2012030135", "2012030136", "2012030137", "2012030321", "2012030322"], "20162017"=>["2016030165"], "20152016"=>["2015030311"]}
     assert_equal 6, @stat_tracker.game_ids_per_season.count
  end

  def test_find_team
    assert_equal "Houston Dynamo", @stat_tracker.find_team("3")
  end

  # League Statistics Methods
  def test_it_can_count_number_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  def test_it_knows_highest_scoring_away
    @stat_tracker.stubs(:highest_scoring_visitor).returns('FC Dallas')
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
    @stat_tracker.stubs(:highest_scoring_home_team).returns('Reign FC')
    assert_equal 'Reign FC', @stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
    @stat_tracker.stubs(:lowest_scoring_visitor).returns('San Jose Earthquakes')
    assert_equal 'San Jose Earthquakes', @stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
    @stat_tracker.stubs(:lowest_scoring_home_team).returns('Utah Royals FC')
    assert_equal 'Utah Royals FC', @stat_tracker.lowest_scoring_home_team
  end
  # League Statistics Helper Methods
  def test_it_can_find_team_name
    assert_equal 'Columbus Crew SC', @stat_tracker.find_team_name('53')
  end

  def test_it_knows_total_games_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_games_per_team_id_away).returns(4)
    assert_equal 4, @stat_tracker.total_games_per_team_id_away
  end

  def test_it_knows_total_games_per_team_id_home
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_games_per_team_id_home).returns(11)
    assert_equal 11, @stat_tracker.total_games_per_team_id_home
  end

  def test_it_knows_total_goals_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_goals_per_team_id_away).returns(5)
    assert_equal 5, @stat_tracker.total_goals_per_team_id_away
  end

  def test_it_knows_total_goals_per_team_id_home
    # expected = {"6"=>12.0, "3"=>3.0, "5"=>1.0, "24"=>6.0, "20"=>3.0}
    @stat_tracker.stubs(:total_goals_per_team_id_home).returns(12)
    assert_equal 12, @stat_tracker.total_goals_per_team_id_home
  end

  def test_it_can_list_team_info
    expected = {
                team_id: '20',
                franchise_id: '21',
                team_name: 'Toronto FC',
                abbreviation: 'TOR',
                link: '/api/v1/teams/20'
              }
    assert_equal expected, @stat_tracker.team_info('20')
  end
end
