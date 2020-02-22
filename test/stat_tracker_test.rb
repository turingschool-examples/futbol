require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    @locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Game, @stat_tracker.games.first
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Team, @stat_tracker.teams.first
    assert_instance_of Array, @stat_tracker.game_teams
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
    assert_instance_of GameStats, @stat_tracker.game_stats
    assert_instance_of LeagueStats, @stat_tracker.league_stats
  end

  def test_it_can_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_can_biggest_blowout
    assert_equal 2, @stat_tracker.biggest_blowout
  end

  def test_it_can_percentage_home_wins
    assert_equal 0.57, @stat_tracker.percentage_home_wins
  end

  def test_it_can_percentage_visitor_wins
    assert_equal 0.29, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_percentage_ties
    assert_equal 0.14, @stat_tracker.percentage_ties
  end

  def test_it_can_count_of_games_by_season
    hash = {"20152016"=>3, "20132014"=>2, "20142015"=>1, "20162017"=>1}
    assert_equal hash, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game
    assert_equal 4.71, @stat_tracker.average_goals_per_game
  end

  def test_it_can_average_goals_by_season
    hash = {"20152016"=>5.33, "20132014"=>5.0, "20142015"=>3.0, "20162017"=>4.0}
    assert_equal hash, @stat_tracker.average_goals_by_season
  end

  def test_it_can_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_it_can_worst_offense
    assert_equal "FC Cincinnati", @stat_tracker.worst_offense
  end

  def test_it_can_highest_scoring_visitor
    assert_equal "Real Salt Lake", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_highest_scoring_home_team
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_lowest_scoring_home_team
    assert_equal "Toronto FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_lowest_scoring_visitor
    assert_equal "FC Cincinnati", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_winningest_team
    assert_equal "Portland Timbers", @stat_tracker.winningest_team
  end

  def test_it_can_best_fans
    assert_equal "FC Dallas", @stat_tracker.best_fans
  end

  def test_it_can_worst_fans
    assert_equal ["Real Salt Lake", "Minnesota United FC"], @stat_tracker.worst_fans
  end
end
