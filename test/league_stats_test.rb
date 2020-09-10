require './test/test_helper'
require './lib/league_stats'
require './lib/stat_tracker'

class LeagueStatsTest <Minitest::Test
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
    @stat_tracker.extend(LeagueStats)
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_with_best_offence
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
    assert_equal 496, @stat_tracker.data_home.count
  end

  def test_away_team_data_collection
    assert_equal 496, @stat_tracker.data_away.count
  end

  def test_average_goals_per_game
    teamdata = {"1" => "I made a big mistake", "2" => "This is not a real team name", "3" => "For testing purposes only"}
    scoredata = [["1", 1], ["1",0], ["1",1], ["2",2], ["2",4],["2",2] ,["3",3], ["3",3], ["3",3]]
    expected = {"1" => 0.6667,"2" => 2.6667,"3" => 3}
    assert_equal expected, @stat_tracker.return_average_goals_per_game(teamdata, scoredata)
  end

  def test_teams_names_data_pull
    assert_equal 32, @stat_tracker.team_names_data.count
  end

end
